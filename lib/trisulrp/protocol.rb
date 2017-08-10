# = Trisul Remote Protocol functions
# 
# dependency = ruby_protobuf
#
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
require 'openssl'
require 'socket'
require 'time'
require 'bigdecimal'

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
  def get_response_zmq(endpoint, trp_request, timeout_seconds = -1 )


    outbuf=""

	# out
   outbuf=trp_request.encode
	ctx=ZMQ::Context.new
	sock = ctx.socket(ZMQ::REQ)

  # time out for context termination
  sock.setsockopt(ZMQ::LINGER, 5*1_000)

	# Initialize a poll set
	poller = ZMQ::Poller.new
	poller.register(sock, ZMQ::POLLIN)
  

	sock.connect(endpoint)
	sock.send_string(outbuf)

	ret = poller.poll(timeout_seconds * 1_000 )
	  if  ret == -1 
			sock.close
			ctx.terminate 
			raise "zeromq poll error #{endpoint} " 
	  end
	  if  ret == 0 
			sock.close
			ctx.terminate 
			raise "no registered sockets #{endpoint} " 
	  end

	poller.readables.each do |rsock|

		#in 
		dataarray=""
		rsock.recv_string(dataarray)
		resp =TRP::Message.new
		resp.decode dataarray
		if resp.trp_command.to_i == TRP::Message::Command::ERROR_RESPONSE
			print "TRP ErrorResponse: #{resp.error_response.error_message}\n"
			rsock.close
			ctx.terminate 
			raise resp.error_response.error_message
		end

		rsock.close
		ctx.terminate 
    unwrap_resp = unwrap_response(resp)
    unwrap_resp.instance_variable_set("@trp_resp_command_id",resp.trp_command.to_i)
		yield unwrap_resp if block_given?
		return unwrap_resp

    end

  end

  # returns response str 
  def get_response_zmq_raw(endpoint, trp_request_buf , timeout_seconds = -1 )


	ctx=ZMQ::Context.new
	sock = ctx.socket(ZMQ::REQ)

	# time out for context termination
	sock.setsockopt(ZMQ::LINGER, 5*1_000)

	# Initialize a poll set
	poller = ZMQ::Poller.new
	poller.register(sock, ZMQ::POLLIN)
  
	sock.connect(endpoint)
	sock.send_string(trp_request_buf)

	ret = poller.poll(timeout_seconds * 1_000 )
	  if  ret == -1 
			sock.close
			ctx.terminate 
			raise "zeromq poll error #{endpoint} " 
	  end
	  if  ret == 0 
			sock.close
			ctx.terminate 
			raise "no registered sockets #{endpoint} " 
	  end

	poller.readables.each do |rsock|

		#in 
		dataarray=""
		rsock.recv_string(dataarray)
		rsock.close
		ctx.terminate 
		return dataarray
    end

  end

  # used in Trisul Domain
  # send trp_request as async, then poll for completion and return
  # this does not block the domain network
  #
  def get_response_zmq_async(endpoint, trp_request, timeout_seconds = -1 )

		# first get a  resp.token ASYNC, then poll for it 
		trp_request.run_async=true
		resp=get_response_zmq(endpoint, trp_request, timeout_seconds)

		trp_resp_command_id = resp.instance_variable_get("@trp_resp_command_id")
    sleep_time = [1,1,1,1,1,1,1,2,2,2,2,2]
    count = 0
		while trp_resp_command_id == TRP::Message::Command::ASYNC_RESPONSE do
      @sleep = sleep_time[count] || 5
      count = count +1
			async_req = TrisulRP::Protocol.mk_request(
							TRP::Message::Command::ASYNC_REQUEST,
							{
								token:resp.token,
								destination_node:trp_request.destination_node,
							}
						)
      #sleep before send async request
      sleep(@sleep)
			resp=get_response_zmq(endpoint,async_req, timeout_seconds)
			trp_resp_command_id = resp.instance_variable_get("@trp_resp_command_id")
		end

		return resp

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
  def get_available_time(conn,timeout=-1)
    
    from_tm=to_tm=nil
    req=mk_request(TRP::Message::Command::TIMESLICES_REQUEST,
                    :get_total_window => true )
    begin
      if conn.is_a?(String)
        resp = get_response_zmq(conn,req,timeout) 
      else
        resp = get_response(conn,req) 
      end 
    rescue Exception=>ex
     raise ex
    end

    from_tm =  Time.at(resp.total_window.from.tv_sec)
    to_tm =  Time.at(resp.total_window.to.tv_sec)

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
	if ( tmarr[0].is_a? Integer)
		tint.from=TRP::Timestamp.new(:tv_sec => tmarr[0], :tv_usec => 0)
		tint.to=TRP::Timestamp.new(:tv_sec => tmarr[1], :tv_usec => 0)
	elsif (tmarr[0].is_a? Time)
		tint.from=TRP::Timestamp.new(:tv_sec => tmarr[0].tv_sec, :tv_usec => 0)
		tint.to=TRP::Timestamp.new(:tv_sec => tmarr[1].tv_sec, :tv_usec => 0)
	end

    return  tint
  end

  # Helper to allow assinging string to KeyT field
  #
  # instead of  
  # ..{ :source_ip => TRP::KeyT.new( :label => val ) } 
  #
  # you can do
  # ..{ :source_ip => val } 
  # 
  def fix_TRP_Fields(msg, params)

	ti = params[:time_interval]
	if ti.is_a? Array
		params[:time_interval] = mk_time_interval(ti)
	end

  	params.each do |k,v|
      f = msg.get_field(k)
      if v.is_a? String 
        if f.is_a? Protobuf::Field::MessageField and f.type_class.to_s == "TRP::KeyT"
          params[k] = TRP::KeyT.new( :label => v )
        elsif f.is_a? Protobuf::Field::Int64Field 
          params[k] = v.to_i
        elsif f.is_a? Protobuf::Field::StringField and f.rule == :repeated  
          params[k] = v.split(',') 
        elsif f.is_a? Protobuf::Field::BoolField
          params[k] = ( v == "true")
        end
      elsif v.is_a? BigDecimal  or v.is_a? Float 
        if f.is_a? Protobuf::Field::Int64Field 
            params[k] = v.to_i
        end
      elsif v.is_a?Array and f.is_a?Protobuf::Field::MessageField and f.type_class.to_s == "TRP::KeyT"
        v.each_with_index do |v1,idx|
          v[idx]= TRP::KeyT.new( :label => v1 ) if v1.is_a?String
        end
      end
	 end

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
  def mk_request(cmd_id,in_params={})
   params  =in_params.dup
   opts = {:trp_command=> cmd_id}
   if params.has_key?(:destination_node)
     opts[:destination_node] = params[:destination_node]
   end
   if params.has_key?(:probe_id)
     opts[:probe_id] = params[:probe_id]
   end
   if params.has_key?(:run_async)
     opts[:run_async] = params[:run_async]
   end
    req = TRP::Message.new(opts)
    case cmd_id
    when TRP::Message::Command::HELLO_REQUEST
	  fix_TRP_Fields( TRP::HelloRequest, params)
      req.hello_request = TRP::HelloRequest.new(params)
    when TRP::Message::Command::COUNTER_GROUP_TOPPER_REQUEST
	  fix_TRP_Fields( TRP::CounterGroupTopperRequest, params)
      req.counter_group_topper_request = TRP::CounterGroupTopperRequest.new(params)
    when TRP::Message::Command::COUNTER_ITEM_REQUEST
	  fix_TRP_Fields( TRP::CounterItemRequest, params)
      req.counter_item_request = TRP::CounterItemRequest.new(params)
    when TRP::Message::Command::PCAP_REQUEST
	  fix_TRP_Fields( TRP::PcapRequest, params)
      req.pcap_request = TRP::PcapRequest.new(params)
    when TRP::Message::Command::SEARCH_KEYS_REQUEST
	  fix_TRP_Fields( TRP::SearchKeysRequest, params)
      req.search_keys_request = TRP::SearchKeysRequest.new(params)
    when TRP::Message::Command::UPDATE_KEY_REQUEST
	  fix_TRP_Fields( TRP::UpdateKeyRequest, params)
      req.update_key_request = TRP::UpdateKeyRequest.new(params)
    when TRP::Message::Command::PROBE_STATS_REQUEST
	  fix_TRP_Fields( TRP::ProbeStatsRequest, params)
      req.probe_stats_request = TRP::ProbeStatsRequest.new(params)
    when TRP::Message::Command::QUERY_ALERTS_REQUEST
	  fix_TRP_Fields( TRP::QueryAlertsRequest, params)
      req.query_alerts_request = TRP::QueryAlertsRequest.new(params)
    when TRP::Message::Command::QUERY_RESOURCES_REQUEST
	  fix_TRP_Fields( TRP::QueryResourcesRequest, params)
      req.query_resources_request = TRP::QueryResourcesRequest.new(params)
    when TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST
	  fix_TRP_Fields( TRP::CounterGroupInfoRequest, params)
      req.counter_group_info_request = TRP::CounterGroupInfoRequest.new(params)
    when TRP::Message::Command::SESSION_TRACKER_REQUEST
	  fix_TRP_Fields( TRP::SessionTrackerRequest, params)
      req.session_tracker_request = TRP::SessionTrackerRequest.new(params)
    when TRP::Message::Command::QUERY_SESSIONS_REQUEST 
	  fix_TRP_Fields( TRP::QuerySessionsRequest, params)
      req.query_sessions_request = TRP::QuerySessionsRequest.new(params)
    when TRP::Message::Command::GREP_REQUEST
	  fix_TRP_Fields( TRP::GrepRequest, params)
      req.grep_request  = TRP::GrepRequest.new(params)
    when TRP::Message::Command::KEYSPACE_REQUEST
	  fix_TRP_Fields( TRP::KeySpaceRequest, params)
      req.key_space_request  = TRP::KeySpaceRequest.new(params)
    when TRP::Message::Command::TOPPER_TREND_REQUEST
	  fix_TRP_Fields( TRP::TopperTrendRequest, params)
      req.topper_trend_request  = TRP::TopperTrendRequest.new(params)
    when TRP::Message::Command::STAB_PUBSUB_CTL 
	  fix_TRP_Fields( TRP::SubscribeCtl, params)
      req.subscribe_ctl = TRP::SubscribeCtl.new(params)
    when TRP::Message::Command::TIMESLICES_REQUEST 
	  fix_TRP_Fields( TRP::TimeSlicesRequest, params)
      req.time_slices_request = TRP::TimeSlicesRequest.new(params)
    when TRP::Message::Command::DELETE_ALERTS_REQUEST 
	  fix_TRP_Fields( TRP::DeleteAlertsRequest, params)
      req.delete_alerts_request = TRP::DeleteAlertsRequest.new(params)
    when TRP::Message::Command::QUERY_FTS_REQUEST 
	  fix_TRP_Fields( TRP::QueryFTSRequest, params)
      req.query_fts_request = TRP::QueryFTSRequest.new(params)
    when TRP::Message::Command::METRICS_SUMMARY_REQUEST
	  fix_TRP_Fields( TRP::MetricsSummaryRequest, params)
      req.metrics_summary_request = TRP::MetricsSummaryRequest.new(params)
    when TRP::Message::Command::CONTEXT_INFO_REQUEST
	  fix_TRP_Fields( TRP::ContextInfoRequest, params)
      req.context_info_request = TRP::ContextInfoRequest.new(params)
    when TRP::Message::Command::CONTEXT_CONFIG_REQUEST
	  fix_TRP_Fields( TRP::ContextConfigRequest, params)
      req.context_config_request = TRP::ContextConfigRequest.new(params)
    when TRP::Message::Command::PCAP_SLICES_REQUEST
	  fix_TRP_Fields( TRP::PcapSlicesRequest, params)
      req.pcap_slices_request = TRP::PcapSlicesRequest.new(params)
    when TRP::Message::Command::LOG_REQUEST
	  fix_TRP_Fields( TRP::LogRequest, params)
      req.log_request = TRP::LogRequest.new(params)
    when TRP::Message::Command::CONTEXT_START_REQUEST
	  fix_TRP_Fields( TRP::ContextStartRequest, params)
      req.context_start_request = TRP::ContextStartRequest.new(params)
    when TRP::Message::Command::CONTEXT_STOP_REQUEST
	  fix_TRP_Fields( TRP::ContextStopRequest, params)
      req.context_stop_request = TRP::ContextStopRequest.new(params)
    when TRP::Message::Command::DOMAIN_REQUEST
	  fix_TRP_Fields( TRP::DomainRequest, params)
      req.domain_request = TRP::DomainRequest.new(params)
    when TRP::Message::Command::ASYNC_REQUEST
	  fix_TRP_Fields( TRP::AsyncRequest, params)
      req.async_request = TRP::AsyncRequest.new(params)
    when TRP::Message::Command::NODE_CONFIG_REQUEST
	  fix_TRP_Fields( TRP::NodeConfigRequest, params)
      req.node_config_request = TRP::NodeConfigRequest.new(params)
    when TRP::Message::Command::FILE_REQUEST
	  fix_TRP_Fields( TRP::FileRequest, params)
      req.file_request = TRP::FileRequest.new(params)
    when TRP::Message::Command::GRAPH_REQUEST
	  fix_TRP_Fields( TRP::GraphRequest, params)
      req.graph_request = TRP::GraphRequest.new(params)
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
    case resp.trp_command.to_i
    when TRP::Message::Command::HELLO_RESPONSE
      resp.hello_response
    when TRP::Message::Command::COUNTER_GROUP_TOPPER_RESPONSE
      resp.counter_group_topper_response
    when TRP::Message::Command::COUNTER_ITEM_RESPONSE
      resp.counter_item_response
    when TRP::Message::Command::OK_RESPONSE
      resp.ok_response
    when TRP::Message::Command::PCAP_RESPONSE
      resp.pcap_response
    when TRP::Message::Command::SEARCH_KEYS_RESPONSE
      resp.search_keys_response
    when TRP::Message::Command::UPDATE_KEY_RESPONSE
      resp.update_key_response 
    when TRP::Message::Command::PROBE_STATS_RESPONSE
        resp.probe_stats_response 
    when TRP::Message::Command::QUERY_ALERTS_RESPONSE
        resp.query_alerts_response 
    when TRP::Message::Command::QUERY_RESOURCES_RESPONSE
        resp.query_resources_response 
    when TRP::Message::Command::COUNTER_GROUP_INFO_RESPONSE
        resp.counter_group_info_response 
    when TRP::Message::Command::SESSION_TRACKER_RESPONSE
        resp.session_tracker_response 
    when TRP::Message::Command::QUERY_SESSIONS_RESPONSE
        resp.query_sessions_response 
    when TRP::Message::Command::GREP_RESPONSE
        resp.grep_response  
    when TRP::Message::Command::KEYSPACE_RESPONSE
        resp.key_space_response  
    when TRP::Message::Command::TOPPER_TREND_RESPONSE
        resp.topper_trend_response  
    when TRP::Message::Command::QUERY_FTS_RESPONSE
        resp.query_fts_response 
    when TRP::Message::Command::TIMESLICES_RESPONSE
        resp.time_slices_response 
    when TRP::Message::Command::METRICS_SUMMARY_RESPONSE
        resp.metrics_summary_response  
    when TRP::Message::Command::CONTEXT_INFO_RESPONSE
        resp.context_info_response
    when TRP::Message::Command::CONTEXT_CONFIG_RESPONSE
        resp.context_config_response
    when TRP::Message::Command::LOG_RESPONSE
        resp.log_response
    when TRP::Message::Command::DOMAIN_RESPONSE
        resp.domain_response
    when TRP::Message::Command::NODE_CONFIG_RESPONSE
        resp.node_config_response
    when TRP::Message::Command::ASYNC_RESPONSE
        resp.async_response
    when TRP::Message::Command::FILE_RESPONSE
        resp.file_response
    when TRP::Message::Command::GRAPH_RESPONSE
        resp.graph_response
    else
     
      raise "#{resp.trp_commandi.to_i} Unknown TRP command ID"
    end
  end
end

