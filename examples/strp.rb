# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './trplib'
include TRPLib

GUID_CG_APP       = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" 

raise "Usage : strp host port" unless ARGV.length==2

# demo a counter group info request
# get information about the application counter group 

trp_conn=TRPLib::connect_trp(ARGV.shift,ARGV.shift,"Demo_Client.crt","Demo_Client.key")


from_tm=to_tm=nil
req=TRPLib::mk_counter_group_info_request(GUID_CG_APP)
TRPLib::get_trp_response(trp_conn,req) do |resp|
	TRPLib::print_counter_group_info_response(resp)

	from_tm =  Time.at(resp.counter_group_info_response.group_details[0].time_interval.from.tv_sec)
	to_tm =  Time.at(resp.counter_group_info_response.group_details[0].time_interval.to.tv_sec)
end

# demo for each session id and their full info  
req=TRPLib::mk_key_session_activity_request("0A.01.A0.E8", from_tm, to_tm)
    get_trp_response(trp_conn,req) do |resp|
	TRPLib::print_key_session_activity_response(resp)
	      resp.key_session_activity_response.sessions.each do|session|
		 req=TRPLib::mk_session_item_request(session.slice_id,session.session_id)
		     get_trp_response(trp_conn,req) do |resp|
		      	 TRPLib::print_session_item_response(resp)
		     end
	      end
    end

