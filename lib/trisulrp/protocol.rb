# = Trisul Remote Protocol functions
# 
# dependency = ruby_protobuf
#
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
require 'openssl'
require 'socket'
require 'time'

begin
FFI_RZMQ_AVAIL=true
require 'ffi-rzmq'
rescue
FFI_RZMQ_AVAIL=false
end


# ==== TrisulRP::Protocol
# Contains methods to help with common TRP tasks like 
# * creating connections
# * interacting with Trisul via requests/responses
# * helpers to create objects
# 
# 

module TrisulRP::Protocol
  include TrisulRP::Guids

  # Establish a TLS connection to a Trisul instance 
  #
  # [server]  IP Address or hostname 
  # [port]    TRP port, typically 12001 (see trisulConfig.xml)
  # [client_cert_file]   Client certificate file issued by admin
  # [client_key_file]   Client key file issued by admin
  #
  #
  # ==== Returns
  # ==== Yields
  # a connection object that can be used in subsequent calls 
  #
  # ==== On error
  # If a connection cannot be established, an exception is thrown which can point 
  # to the actual cause. The most common causes are  
  #
  # * Trisul is not running 
  # * Trisul is not running in trp mode (see the docs for runmode)
  # * Using the wrong port ( check netstat to verify trisul remote protocol port - typically 12001)
  # * The Access Control List does not permit connections from client IP
  # * The server certificate expired
  # * The client certificate expired
  # * The client does not have permissions to connect with that cert 
  # * The private key password is wrong 
  #
  def connect(server,port,client_cert_file,client_key_file)
    tcp_sock=TCPSocket.open(server,port)
    ctx = OpenSSL::SSL::SSLContext.new(:TLSv1)
    ctx.cert = OpenSSL::X509::Certificate.new(File.read(client_cert_file))
    ctx.key = OpenSSL::PKey::RSA.new(File.read(client_key_file))
    ssl_sock = OpenSSL::SSL::SSLSocket.new(tcp_sock, ctx)
    ssl_sock.connect
    yield ssl_sock if block_given?
    return ssl_sock
  end

  # Establish a *NONSECURE PLAINTEXT* connection to a Trisul instance 
  #
  # We highly recommend  you to use the TLS connect(..) method, but if
  # you must use plaintext use this version. This is purposely named
  # connect_nonsecure(..) to drive home the point that there is no
  # authentication using client certs, or no encryption. 
  #
  # You can still use the ACL (Access Control List) to control who connects
  #
  #
  # [server]  IP Address or hostname 
  # [port]    TRP port, typically 12001 (see trisulConfig.xml)
  #
  #
  # ==== Returns
  # ==== Yields
  # a connection object that can be used in subsequent calls 
  #
  # ==== On error
  # If a connection cannot be established, an exception is thrown which can point 
  # to the actual cause. The most common causes are  
  #
  # * Trisul is not running 
  # * Trisul is not running in trp mode (see the docs for runmode)
  # * Using the wrong port ( check netstat to verify trisul remote protocol port - typically 12001)
  # * The Access Control List does not permit connections from client IP
  #
  def connect_nonsecure(server,port)

    tcp_sock=TCPSocket.open(server,port)
    yield tcp_sock if block_given?
    return tcp_sock

  end


  # Dispatch request to server & get response 
  # [conn]  TRP connection  previously opened via TrisulRP::Protocol::connect
  #
  #         - connection can a ZMQ endpoint string like zmq:ipc://.. if string starts
  #           with 'zmq:' it will be treated as ZMQ.
  #
  #         Needs ffi-rzmq gem
  #
  # [trp_request]  a TRP request object, created directly or using the mk_request helper 
  #
  # ==== Returns
  # ==== Yields
  # a response object, you can then inspect the fields in the response and spawn additional 
  # requests if required 
  #
  # ==== On error
  # raises an error if the server returns an ErrorResponse - this contains an error_message field
  # which can tell you what went wrong
  #
  def get_response(conn,trp_request)
    outbuf=""
    outbuf=trp_request.serialize_to_string

	conn.write([outbuf.length].pack("N*"))
	conn.write(outbuf)

    inbuf=""
	inbuf = conn.read(4)
    buflenarr=inbuf.unpack("N*")
    datalen=buflenarr[0]
    dataarray=conn.read(datalen)
    resp =TRP::Message.new
    resp.parse dataarray
    if resp.trp_command == TRP::Message::Command::ERROR_RESPONSE
		print "TRP ErrorResponse: #{resp.error_response.error_message}\n"
		raise resp.error_response.error_message
	end
    yield unwrap_response(resp) if block_given?
    return unwrap_response(resp)
  end

  # Using ZMQ to Dispatch request to server & get response 
  #
  # This is used by new webtrisul architecuter to connect to trisul_queryd 
  #
  # [conn]  - a ZMQ endpoint string like ipc://.. 
  #
  #         Needs ffi-rzmq gem
  #
  # [trp_request]  a TRP request object, created directly or using the mk_request helper 
  #
  # ==== Returns
  # ==== Yields
  # a response object, you can then inspect the fields in the response and spawn additional 
  # requests if required 
  #
  # ==== On error
  # raises an error if the server returns an ErrorResponse - this contains an error_message field
  # which can tell you what went wrong
  #
  def get_response_zmq(endpoint, trp_request)

    outbuf=""

	# out
    outbuf=trp_request.serialize_to_string
	ctx=ZMQ::Context.new
	sock = ctx.socket(ZMQ::REQ)
	sock.connect(endpoint)
	sock.send_string(outbuf)


	#in 
	dataarray=""
	sock.recv_string(dataarray)
    resp =TRP::Message.new
    resp.parse dataarray
    if resp.trp_command == TRP::Message::Command::ERROR_RESPONSE
		print "TRP ErrorResponse: #{resp.error_response.error_message}\n"
		sock.close
		ctx.terminate 
		raise resp.error_response.error_message
	end

	sock.close
	ctx.terminate 

    yield unwrap_response(resp) if block_given?
    return unwrap_response(resp)

  end



  # Query the total time window available in Trisul
  # 
  # [conn]  TRP connection  previously opened via connect
  #
  # ==== Returns
  # returns an array of two Time objects [Time_from, Time_to] representing start and end time 
  #
  # ==== Typical usage 
  #
  # You pass the output of this method to mk_time_interval to get an object you can attach to a 
  # TRP request.
  #
  # <code>
  #
  #   tmarr = TrisulRP::Protocol::get_avaiable_time(conn)
  #   req = TrisulRP::Protocol.mk_request( :source_ip => target_ip,...
  #            :time_interval => TrisulRP::Protocol::mk_time_interval(tm_arr))
  #
  # </code>
  #
  def get_available_time(conn)
    
    from_tm=to_tm=nil
    req=mk_request(TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST,
                    :counter_group => TrisulRP::Guids::CG_AGGREGATE)

	if conn.is_a?(String)
		resp = get_response_zmq(conn,req) 
	else
		resp = get_response(conn,req) 
	end 


    from_tm =  Time.at(resp.group_details[0].time_interval.from.tv_sec)
    to_tm =  Time.at(resp.group_details[0].time_interval.to.tv_sec)

    return [from_tm,to_tm]

  end


  # Helper to create a TRP TimeInterval object
  #
  # [tmarr]  An array of two Time objects representing a window
  #
  # ==== Returns
  # A TRP::TimeInterval object which can be attached to any :time_interval field of a TRP request
  #
  def mk_time_interval(tmarr)
    tint=TRP::TimeInterval.new
    tint.from=TRP::Timestamp.new(:tv_sec => tmarr[0].tv_sec, :tv_usec => 0)
    tint.to=TRP::Timestamp.new(:tv_sec => tmarr[1].tv_sec, :tv_usec => 0)
    return  tint
  end

  # Helper to create a TRP request object
  #
  # Read the TRP documentation wiki for a description of each command. 
  #
  # [cmd_id] The command ID. 
  # [params] A hash containing command parameters
  #
  # ==== Typical usage
  #
  # <code>
  #
  #  # create a new command of type QuerySessionsRequest
  #  req = TrisulRP::Protocol.mk_request(TRP::Message::Command::QUERY_SESSIONS_REQUEST,
  #            :source_ip => .. ,
  #            :time_interval => mk_time_interval(tmarr))
  #
  #  ... now you can use the req object ...
  #
  # </code>
  #
  # You can also create the request objects directly, just a little too verbose for our liking
  #
  # <code>
  #
  #  # create a new command of type CounterItemRequest
  #  req =TRP::Message.new(:trp_command => TRP::Message::Command::QUERY_SESSIONS_REQUEST )
  #  req.query_sessions_request = TRP::QuerySessionsRequest.new( 
  #            :source_ip =>  ... ,
  #            :time_interval => mk_time_interval(tmarr))
  #
  #  ... now you can use the req object ...
  #
  # </code>
  #
  #
  def mk_request(cmd_id,params={})
    req = TRP::Message.new(:trp_command => cmd_id)
    case cmd_id
    when TRP::Message::Command::HELLO_REQUEST
      req.hello_request = TRP::HelloRequest.new(params)
    when TRP::Message::Command::COUNTER_GROUP_REQUEST
      req.counter_group_request = TRP::CounterGroupRequest.new(params)
    when TRP::Message::Command::COUNTER_ITEM_REQUEST
      req.counter_item_request = TRP::CounterItemRequest.new(params)
    when TRP::Message::Command::RELEASE_RESOURCE_REQUEST
      req.release_resource_request = TRP::ReleaseResourceRequest.new(params)
    when TRP::Message::Command::CONTROLLED_COUNTER_GROUP_REQUEST
      req.controlled_counter_group_request = TRP::ControlledCounterGroupRequest.new(params)
    when TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST
      req.filtered_datagram_request = TRP::FilteredDatagramRequest.new(params)
    when TRP::Message::Command::CONTROLLED_CONTEXT_REQUEST
      req.controlled_context_request = TRP::ControlledContextRequest.new(params)
    when TRP::Message::Command::SEARCH_KEYS_REQUEST
      req.search_keys_request = TRP::SearchKeysRequest.new(params)
    when TRP::Message::Command::BULK_COUNTER_ITEM_REQUEST
      req.bulk_counter_item_request = TRP::BulkCounterItemRequest.new(params)
    when TRP::Message::Command:: CGMONITOR_REQUEST
      req.cgmonitor_request = TRP::CgmonitorRequest.new(params)
    when TRP::Message::Command::TOPPER_SNAPSHOT_REQUEST
      req.topper_snapshot_request = TRP::TopperSnapshotRequest.new(params)
    when TRP::Message::Command::UPDATE_KEY_REQUEST
      req.update_key_request = TRP::UpdateKeyRequest.new(params)
    when TRP::Message::Command::RING_STATS_REQUEST
      req.ring_stats_request = TRP::RingStatsRequest.new(params)
    when TRP::Message::Command::SERVER_STATS_REQUEST
      req.server_stats_request = TRP::ServerStatsRequest.new(params)
    when TRP::Message::Command::SESSION_ITEM_REQUEST
      req.session_item_request = TRP::SessionItemRequest.new(params)
    when TRP::Message::Command::SESSION_GROUP_REQUEST
      req.session_group_request = TRP::SessionGroupRequest.new(params)
    when TRP::Message::Command::QUERY_ALERTS_REQUEST
      req.query_alerts_request = TRP::QueryAlertsRequest.new(params)
    when TRP::Message::Command::QUERY_RESOURCES_REQUEST
      req.query_resources_request = TRP::QueryResourcesRequest.new(params)
    when TRP::Message::Command::KEY_LOOKUP_REQUEST
      req.key_lookup_request = TRP::KeyLookupRequest.new(params)
    when TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST
      req.counter_group_info_request = TRP::CounterGroupInfoRequest.new(params)
    when TRP::Message::Command::SESSION_TRACKER_REQUEST
      req.session_tracker_request = TRP::SessionTrackerRequest.new(params)
    when TRP::Message::Command::QUERY_SESSIONS_REQUEST 
      req.query_sessions_request = TRP::QuerySessionsRequest.new(params)
    when TRP::Message::Command::GREP_REQUEST
      req.grep_request  = TRP::GrepRequest.new(params)
    when TRP::Message::Command::KEYSPACE_REQUEST
      req.keyspace_request  = TRP::KeySpaceRequest.new(params)
    when TRP::Message::Command::TOPPER_TREND_REQUEST
      req.topper_trend_request  = TRP::TopperTrendRequest.new(params)
    when TRP::Message::Command::QUERY_PDP_REQUEST 
      req.query_pdp_request = TRP::QueryPDPRequest.new(params)
    when TRP::Message::Command::STAB_PUBSUB_CTL 
      req.subscribe_ctl = TRP::SubscribeCtl.new(params)
    else
      raise "Unknown TRP command ID"
    end
    return req
  end

  # Helper to unwrap a response
  #
  # All protobuf messages used in TRP have a wrapper containing a command_id which identifies
  # the type of encapsulated message. This sometimes gets in the way because you have to write
  # stuff like
  #
  # <code>
  #
  #     response.counter_group_response.blah_blah 
  #
  #     instead of 
  #
  #     response.blah_blah
  #
  # </code>
  #
  # Read the TRP documentation wiki for a description of each command. 
  #
  # [resp] The response 
  #
  # ==== Typical usage
  #
  # <code>
  #
  #  # create a new command of type KeySessionActivityRequest
  #  req = TrisulRP::Protocol.get_response(...) do |resp|
  #      
  #     # here resp points to the inner response without the wrapper 
  #     # this allows you to write resp.xyz instead of resp.hello_response.xyz 
  #
  #  end
  #
  # </code>
  #
  #
  def unwrap_response(resp)
    case resp.trp_command
    when TRP::Message::Command::HELLO_RESPONSE
      resp.hello_response
    when TRP::Message::Command::COUNTER_GROUP_RESPONSE
      resp.counter_group_response
    when TRP::Message::Command::COUNTER_ITEM_RESPONSE
      resp.counter_item_response
    when TRP::Message::Command::OK_RESPONSE
      resp.ok_response
    when TRP::Message::Command::CONTROLLED_COUNTER_GROUP_RESPONSE
      resp.controlled_counter_group_response
    when TRP::Message::Command::FILTERED_DATAGRAMS_RESPONSE
      resp.filtered_datagram_response
    when TRP::Message::Command::CONTROLLED_CONTEXT_RESPONSE
      resp.controlled_context_response
    when TRP::Message::Command::SEARCH_KEYS_RESPONSE
      resp.search_keys_response
    when TRP::Message::Command::BULK_COUNTER_ITEM_RESPONSE
        resp.bulk_counter_item_response 
    when TRP::Message::Command:: CGMONITOR_RESPONSE
        resp.cgmonitor_response 
    when TRP::Message::Command::TOPPER_SNAPSHOT_RESPONSE
      resp.topper_snapshot_response
    when TRP::Message::Command::UPDATE_KEY_RESPONSE
      resp.update_key_response 
    when TRP::Message::Command::RING_STATS_RESPONSE
        resp.ring_stats_response 
    when TRP::Message::Command::SERVER_STATS_RESPONSE
        resp.server_stats_response 
    when TRP::Message::Command::SESSION_ITEM_RESPONSE
        resp.session_item_response 
    when TRP::Message::Command::SESSION_GROUP_RESPONSE
        resp.session_group_response 
    when TRP::Message::Command::QUERY_ALERTS_RESPONSE
        resp.query_alerts_response 
    when TRP::Message::Command::QUERY_RESOURCES_RESPONSE
        resp.query_resources_response 
    when TRP::Message::Command::KEY_LOOKUP_RESPONSE
        resp.key_lookup_response 
    when TRP::Message::Command::COUNTER_GROUP_INFO_RESPONSE
        resp.counter_group_info_response 
    when TRP::Message::Command::SESSION_TRACKER_RESPONSE
        resp.session_tracker_response 
    when TRP::Message::Command::QUERY_SESSIONS_RESPONSE
        resp.query_sessions_response 
    when TRP::Message::Command::GREP_RESPONSE
        resp.grep_response  
    when TRP::Message::Command::KEYSPACE_RESPONSE
        resp.keyspace_response  
    when TRP::Message::Command::TOPPER_TREND_RESPONSE
        resp.topper_trend_response  
    when TRP::Message::Command::QUERY_PDP_RESPONSE
        resp.query_pdp_response 
    else
      raise "Unknown TRP command ID"
    end
  end
end

