# = Trisul Remote Protocol helper  functions
# 
# dependency = ruby_protobuf
#
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
require 'openssl'
require 'socket'
require 'time'

module TrisulRP::Protocol
	include TrisulRP::Guids

	# == TLS Connect to a Trisul instance 
	# => server : IP Address or hostname 
	# => port   : TRP port, typically 12001 (see trisulConfig.xml)
	# => client_cert_file  : Client certificate file issued by admin
	# => client_key_file  : Client key file issued by admin
	#
	# yields or returns a connection object that can be used in subsequent
	# calls to communicate to the trisul instance 
	#
	#
	def connect(server,port,client_cert_file,client_key_file)
		tcp_sock=TCPSocket.open(server,port)
		ctx = OpenSSL::SSL::SSLContext.new
		ctx.cert = OpenSSL::X509::Certificate.new(File.read(client_cert_file))
		ctx.key = OpenSSL::PKey::RSA.new(File.read(client_key_file))
		ssl_sock = OpenSSL::SSL::SSLSocket.new(tcp_sock, ctx)
		ssl_sock.connect
		yield ssl_sock if block_given?
		return ssl_sock
	end

	# == Dispatch request & get response 
	# => trp_socket : socket previously opened via connect_trp
	# => trp_request : a TRP request object
	#
	# yields or returns a response object 
	# raises an error if the server returns an ErrorResponse
	#
	def get_response(trp_socket,trp_request)
		outbuf=""
		outbuf=trp_request.serialize_to_string
		trp_socket.write([outbuf.length].pack("N*"))
		trp_socket.write(outbuf)
		inbuf = trp_socket.read(4)
		buflenarr=inbuf.unpack("N*")
		datalen=buflenarr[0]
		dataarray=trp_socket.read(datalen)
		resp =TRP::Message.new
		resp.parse dataarray
		raise resp.error_response if resp.trp_command == TRP::Message::Command::ERROR_RESPONSE
		yield resp if block_given?
		return resp
	end


  # returns an array of [Time_from, Time_to] representing time window available on Trisul
  def get_available_time(conn)
		from_tm=to_tm=nil
		req=mk_request(TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST,
      :counter_group => TrisulRP::Guids::CG_AGGREGATE)
		get_response(conn,req) do |resp|
			from_tm =  Time.at(resp.counter_group_info_response.group_details[0].time_interval.from.tv_sec)
			to_tm =  Time.at(resp.counter_group_info_response.group_details[0].time_interval.to.tv_sec)
		end
		return [from_tm,to_tm]
  end

  # returns a hash of key => label
  def get_labels_for_keys(conn, cgguid, key_arr)
    req = mk_request(TRP::Message::Command::KEY_LOOKUP_REQUEST,
      :counter_group  => cgguid, :keys => key_arr.uniq )
    h = key_arr.inject({}) { |m,i| m.store(i,i); m }
    get_response(conn,req) do |resp|
			resp.key_lookup_response.key_details.each { |d| h.store(d.key,d.label) }
    end
    return h
  end

  # fill up time_intergal 
  def mk_time_interval(tmarr)
    tint=TRP::TimeInterval.new
    tint.from=TRP::Timestamp.new(:tv_sec => tmarr[0].tv_sec, :tv_usec => 0)
    tint.to=TRP::Timestamp.new(:tv_sec => tmarr[1].tv_sec, :tv_usec => 0)
    return tint
  end

  # shortcut to make a request 
  def mk_request(cmd_id,params)
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
      req.filtered_datagrams_request = TRP::FilteredDatagramsRequest.new(params)
    when TRP::Message::Command::CONTROLLED_CONTEXT_REQUEST
      req.controlled_context_request = TRP::ControlledContextRequest.new(params)
    when TRP::Message::Command::SEARCH_KEYS_REQUEST
      req.search_keys_request = TRP::SearchKeysRequest.new(params)
    when TRP::Message::Command::BULK_COUNTER_ITEM_REQUEST
      req.bulk_counter_item_request = TRP::BulkItemRequest.new(params)
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
    when TRP::Message::Command::ALERT_ITEM_REQUEST
      req.alert_item_request = TRP::AlertItemRequest.new(params)
    when TRP::Message::Command::ALERT_GROUP_REQUEST
      req.alert_group_request = TRP::AlertGroupRequest.new(params)
    when TRP::Message::Command::RESOURCE_ITEM_REQUEST
      req.resource_item_request = TRP::ResourceItemRequest.new(params)
    when TRP::Message::Command::RESOURCE_GROUP_REQUEST
      req.resource_group_request = TRP::ResourceGroupRequest.new(params)
    when TRP::Message::Command::KEY_LOOKUP_REQUEST
      req.key_lookup_request = TRP::KeyLookupRequest.new(params)
    when TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST
	  req.counter_group_info_request = TRP::CounterGroupInfoRequest.new(params)
	when TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST
      req.key_session_activity_request = TRP::KeySessionActivityRequest.new(params)
  	else
		raise "Unknown TRP command ID"
    end
    return req
  end

end

