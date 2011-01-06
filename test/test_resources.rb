# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'


require './helper'
include TRPLib

GUID_CG_APP       = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" 

class TestTrisulrp < Test::Unit::TestCase

	def setup
		if @trp_conn.nil?
		@trp_conn=TRPLib::connect_trp("127.0.0.1",
									  12001,
									  "Demo_Client.crt",
									  "Demo_Client.key")
		end
	end


	def itest_resource_items 
		req=TRPLib::mk_resource_item_request(1,[574,575])
		get_trp_response(@trp_conn,req) do |resp|
				TRPLib::print_resource_item_response(resp)
		end
	end

	def test_query_resources

		target_ip = "0A.02.C7.EB"  # 10.2.199.235"
		tm_arr = TRPLib::get_available_time(@trp_conn)


		# The Request 
		# ----------
     	req =TRP::Message.new(:trp_command => TRP::Message::Command::RESOURCE_GROUP_REQUEST)
     	req.resource_group_request =TRP::ResourceGroupRequest.new( :context => 0, 
																   :resource_group => "{4EF9DEB9-4332-4867-A667-6A30C5900E9E}",
																   :uri_pattern => "dll",
																   :maxitems  => 1000,
																   :time_interval => TRPLib.mk_time_interval(tm_arr)
																  )

		# The Response
		# ------------
		get_trp_response(@trp_conn,req) do |resp|

			follow_up = TRP::Message.new(:trp_command => TRP::Message::Command::RESOURCE_ITEM_REQUEST)
			follow_up.resource_item_request = TRP::ResourceItemRequest.new(:context => 0, :resource_group => "{4EF9DEB9-4332-4867-A667-6A30C5900E9E}")
			resp.resource_group_response.resources.each do |res|
				follow_up.resource_item_request.resource_ids << TRP::ResourceID.new(:slice_id => res.slice_id, :resource_id => res.resource_id)
			end

			get_trp_response(@trp_conn,follow_up) do | resp2 |

				  resp=resp2.resource_item_response
				  resp.items.each do |item|
							print "#{Time.at(item.time.tv_sec)} "
							print "#{item.source_ip}".ljust(28)
							print "#{item.source_port}".ljust(11)
							print "#{item.destination_ip}".ljust(28)
							print "#{item.destination_port}".ljust(11)
							print "#{item.uri}".rjust(10)
							print "\n"
				  end 
			end
		end

	
	end
end


