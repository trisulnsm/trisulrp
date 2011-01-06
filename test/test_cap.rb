# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './helper'
include TRPLib
require 'guidmap'


class TestCap < Test::Unit::TestCase

	def setup
		@trp_conn=TRPLib::connect("127.0.0.1",
								  12001,
								  "Demo_Client.crt",
								  "Demo_Client.key")
	end


	def test_dpi

	 target_sess = TRP::SessionID.new(:slice_id => 2, :session_id => 207) 
	 #target_sess = TRP::SessionID.new(:slice_id => 2, :session_id => 4375 ) 

	 # get session time 
     req =TRP::Message.new(:trp_command => TRP::Message::Command::SESSION_ITEM_REQUEST )
     req.session_item_request  = 
	 			TRP::SessionItemRequest.new(:session_ids  =>  [target_sess])

	 resp=TRPLib::get_trp_response(@trp_conn,req) do |resp|
	 	si = resp.session_item_response.items[0]

	 	follow_up = TRP::Message.new(:trp_command => TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST)
		follow_up.filtered_datagram_request = TRP::FilteredDatagramRequest.new(
							:filter_expression  => "#{GUIDMap::SG_TCP}=#{si.session_key}",
							:time_interval => si.time_interval )
	 	TRPLib::get_trp_response(@trp_conn,follow_up) do |resp|
			fdr=resp.filtered_datagram_response

			p "Number of bytes = #{fdr.num_bytes}\n"
			p "Number of pkts  = #{fdr.num_datagrams}\n"
			p "Hash            = #{fdr.sha1}\n"

			File.open("t.pcap","wb") do |f|
					f.write(fdr.contents)
			end
		end

	 end
end

end


