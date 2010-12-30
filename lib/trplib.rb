# TRP Helper functions
# 
# dependency = ruby_protobuf
#
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks

require 'openssl'
require 'socket'
require 'time'
require './trp.pb'

module TRPLib

	# dispatch and get trp response
	def     get_trp_response(trp_socket,trp_request)

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
		yield resp if block_given?
		return resp
	end

	def    connect_trp(server,port,client_cert_file,client_key_file)
		tcp_sock=TCPSocket.open(server,port)
		ctx = OpenSSL::SSL::SSLContext.new
		ctx.cert = OpenSSL::X509::Certificate.new(File.read(client_cert_file))
		ctx.key = OpenSSL::PKey::RSA.new(File.read(client_key_file))
		ssl_sock = OpenSSL::SSL::SSLSocket.new(tcp_sock, ctx)
		ssl_sock.connect
		yield ssl_sock if block_given?
		return ssl_sock
	end



  # creates a counter item request message by filling in the
  # protobuf 
  def mk_counter_item_request(guid,key,time_from,time_to)

     # create a new command of type CounterItemRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::COUNTER_ITEM_REQUEST
     msg.counter_item_request =TRP:: CounterItemRequest.new
     cir_msg=msg.counter_item_request

     # fill in basic info
     cir_msg.context =0
     cir_msg.counter_group=guid
     cir_msg.meter=0
     cir_msg.key=key
   
     # fill in time_interval
     cir_msg.time_interval=TRP::TimeInterval.new
     tint=cir_msg.time_interval
     tint.from=TRP::Timestamp.new
     tint.from.tv_sec=time_from.tv_sec
     tint.from.tv_usec=0
     tint.to=TRP::Timestamp.new
     tint.to.tv_sec=time_to.tv_sec
     tint.to.tv_usec=0
     return msg
 end

 # print stats
 def print_counter_item_response(resp_in)
        
	resp=resp_in.counter_item_response
	p "---------------------"
	p "Counter Item Response"
	p "---------------------"
	p "Key = " + resp.stats.key
	p "CounterGroup  = " + resp.stats.counter_group
        p "Context = #{ resp.stats.context}"
        resp.stats.meters.each do |meter|
            	p "Meter = #{meter.meter }"
                  meter.values.each do |stats_tuple|
                  print  Time.at(stats_tuple.ts.tv_sec)     
		  print  "#{stats_tuple.val }".rjust(16)
		  print "\n"
                end
         end       

 end

 def mk_counter_group_info_request(guid)

     # create a new command of type CounterGroupInfoRequest
     
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST
     msg.counter_group_info_request =TRP:: CounterGroupInfoRequest.new
	 cgir_msg=msg.counter_group_info_request

     # fill in basic info
     
     cgir_msg.context =0
     cgir_msg.counter_group=guid	
     return msg

 end

 
 def print_counter_group_info_response(resp_in)
	
	resp=resp_in.counter_group_info_response

	p "----------------------------"
	p "Counter Group Info Response"
	p "----------------------------"
	p "Context = #{ resp.context}"
    resp.group_details.each do |group_detail|
		p "Name = #{ group_detail.name}"
		p "Guid = " + group_detail.guid
		p "Bucket Size = #{ group_detail.bucket_size}"
        	p Time.at(group_detail.time_interval.from.tv_sec)
		p Time.at(group_detail.time_interval.to.tv_sec)
    end	 
 end

  	

def mk_session_group_request()

     # create a new command of type CounterItemRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::SESSION_GROUP_REQUEST
     msg.session_group_request =TRP:: SessionGroupRequest.new
     sgr_msg=msg.session_group_request

     # fill in basic info
     sgr_msg.context =0
     sgr_msg.maxitems=100
     sgr_msg.tracker_id=1
     sgr_msg.session_group="{99A78737-4B41-4387-8F31-8077DB917336}" 		
     
     return msg
 
 end

def print_session_group_response(resp_in)

	resp=resp_in.session_group_response

	p "----------------------------"
	p "Session Group Response"
	p "----------------------------"
	p "Context = #{ resp.context}"
	p "Session Group = " + resp.session_group
	resp.session_keys.each do |session_key|
		p "Session Key = " + session_key
	end

end

 # creates a counter group request message by filling in the
 # protobuf 

def mk_counter_group_request(guid,time_from,time_to,time_instant)

     # create a new command of type CounterGroupRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::COUNTER_GROUP_REQUEST
     msg.counter_group_request =TRP:: CounterGroupRequest.new
     cir_msg=msg.counter_group_request

     # fill in basic info
     cir_msg.context =0
     cir_msg.counter_group=guid
     cir_msg.meter=0
     cir_msg.maxitems=20

   
     # fill in time_interval
     cir_msg.time_interval=TRP::TimeInterval.new
     tint=cir_msg.time_interval
     tint.from=TRP::Timestamp.new
     tint.from.tv_sec=time_from.tv_sec
     tint.from.tv_usec=0
     tint.to=TRP::Timestamp.new
     tint.to.tv_sec=time_to.tv_sec
     tint.to.tv_usec=0

     #fill in time_instant
     #cir_msg.time_instant=TRP::Timestamp.new
     #cir_msg.time_instant.tv_sec=time_instant.tv_sec+1000
     #cir_msg.time_instant.tv_usec=0
     return msg
 end

# print response

def print_counter_group_response(resp_in)
    resp=resp_in.counter_group_response
	p "..........................."
	p "Counter  Group Response"
	p "---------------------"
        p "Context = #{ resp.context}"
        p "CounterGroup  = " + resp.counter_group
        p  "Meters= #{resp.meter}"
        resp.keys.each do|key|
        	p "key => " + key.label
        end
 end

def mk_key_session_activity_request(key,time_from,time_to)

     # create a new command of type CounterItemRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST
     msg.key_session_activity_request =TRP::KeySessionActivityRequest.new
     ksar_msg=msg.key_session_activity_request

     # fill in basic info
     ksar_msg.context =0
     ksar_msg.maxitems=100
     ksar_msg.session_group="{99A78737-4B41-4387-8F31-8077DB917336}"
     ksar_msg.key= key
     ksar_msg.duration_filter=9
     ksar_msg.volume_filter=10		 		
   
     # fill in time_interval
     ksar_msg.time_interval=TRP::TimeInterval.new
     tint=ksar_msg.time_interval
     tint.from=TRP::Timestamp.new
     tint.from.tv_sec=time_from.tv_sec
     tint.from.tv_usec=0
     tint.to=TRP::Timestamp.new
     tint.to.tv_sec=time_to.tv_sec
     tint.to.tv_usec=0
     return msg
 
 end

def print_key_session_activity_response(resp_in)

	resp=resp_in.key_session_activity_response

	p "----------------------------"
	p "Session Item Response"
	p "----------------------------"
	p "Context = #{ resp.context}"
	p "Session Group = " + resp.session_group
        
end

  # creates a session item request  
  # gets details about a sessionid 
def mk_session_item_request(slice_id,session_id)

     # create a new command of type SessionItemRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::SESSION_ITEM_REQUEST
     msg.session_item_request =TRP::SessionItemRequest.new
     cir_msg=msg.session_item_request

     # fill in basic info (guid = session id for flows)
     cir_msg.context =0
     cir_msg.session_group="{99A78737-4B41-4387-8F31-8077DB917336}"
     cir_msg.session_id = TRP::SessionID.new
     cir_msg.session_id.slice_id=slice_id
     cir_msg.session_id.session_id=session_id

     return msg
 end

 # prints a neat table of session activity 
 def print_session_item_response(resp_in)
  resp=resp_in.session_item_response
	print "#{resp.state} "
    print "#{Time.at(resp.time_interval.from.tv_sec)} "
	print "#{resp.time_interval.to.tv_sec-resp.time_interval.from.tv_sec} ".rjust(8)
    print "#{resp.key1A.label}".ljust(28)
	print "#{resp.key2A.label}".ljust(11)
    print "#{resp.key1Z.label}".ljust(28)
	print "#{resp.key2Z.label}".ljust(11)
    print "#{resp.az_bytes}".rjust(10)
    print "#{resp.za_bytes}".rjust(10)
    print "\n"
 
 end
  
	
  def mk_session_tracker_request(time_from,time_to)

     # create a new command of type CounterItemRequest
     msg =TRP::Message.new 
     msg.trp_command = TRP::Message::Command::SESSION_TRACKER_REQUEST
     msg.session_tracker_request =TRP:: SessionTrackerRequest.new
     str_msg=msg.session_tracker_request

     # fill in basic info
     str_msg.context =0
     str_msg.maxitems=100
     str_msg.tracker_id=1
     str_msg.session_group="{99A78737-4B41-4387-8F31-8077DB917336}" 		
   
     # fill in time_interval
     str_msg.time_interval=TRP::TimeInterval.new
     tint=str_msg.time_interval
     tint.from=TRP::Timestamp.new
     tint.from.tv_sec=time_from.tv_sec
     tint.from.tv_usec=0
     tint.to=TRP::Timestamp.new
     tint.to.tv_sec=time_to.tv_sec
     tint.to.tv_usec=0
     return msg
 
 end

def print_session_tracker_response(resp_in)

	resp=resp_in.session_tracker_response

	p "----------------------------"
	p "Session Tracker Response"
	p "----------------------------"
	p "Context = #{ resp.context}"
	p "Session Group = " + resp.session_group
       
	end	




end
