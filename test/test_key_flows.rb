# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'


require './helper'
include TRPLib

GUID_CG_APP       = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" 

class TestTrisulrp < Test::Unit::TestCase

	def setup
		@trp_conn=TRPLib::connect_trp("127.0.0.1",
									  12001,
									  "Demo_Client.crt",
									  "Demo_Client.key")
	end


	def test_flows_for_host

	 target_key =  "0A.01.3C.BB"

	 tmarr  = TRPLib::get_available_time(@trp_conn)

     # create a new command of type CounterItemRequest
     req =TRP::Message.new(:trp_command => TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST )

     req.key_session_activity_request = 
	 			TRP::KeySessionActivityRequest.new( :key =>  target_key ,
	 	                                            :time_interval => TRPLib::mk_time_interval(tmarr))
	 TRPLib::get_trp_response(@trp_conn,req) do |resp|

		all_sids = resp.key_session_activity_response.sessions.collect { |ai| TRP::SessionID.new(:slice_id => ai.slice_id, :session_id => ai.session_id ) }

	 	follow_up = TRP::Message.new(:trp_command => TRP::Message::Command::SESSION_ITEM_REQUEST)
		follow_up.session_item_request = TRP::SessionItemRequest.new(:session_ids => all_sids)
	 	TRPLib::get_trp_response(@trp_conn,follow_up) do |resp|
			resp.session_item_response.items.each do |item|
				print "#{item.state} "
				print "#{Time.at(item.time_interval.from.tv_sec)} "
				print "#{item.time_interval.to.tv_sec-item.time_interval.from.tv_sec} ".rjust(8)
				print "#{item.key1A.label}".ljust(28)
				print "#{item.key2A.label}".ljust(11)
				print "#{item.key1Z.label}".ljust(28)
				print "#{item.key2Z.label}".ljust(11)
				print "#{item.az_bytes}".rjust(10)
				print "#{item.za_bytes}".rjust(10)
				print "\n"
			end


		end
	 end
end

end


