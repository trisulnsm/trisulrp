# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './helper'
include TRPLib

GUID_CG_APP       = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" 

AG_IDS   = "{9AFD8C08-07EB-47E0-BF05-28B4A7AE8DC9}"
CG_SIGDS = "{A0FA9464-B496-4A20-A9AB-4D2D09AFF902}"

CG_HOSTS = "{4CD742B1-C1CA-4708-BE78-0FCA2EB01A86}" 
CG_APPS  = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" 


class TestTrisulrp < Test::Unit::TestCase

	def setup
		if @trp_conn.nil?
		@trp_conn=TRPLib::connect_trp("127.0.0.1",
									  12001,
									  "Demo_Client.crt",
									  "Demo_Client.key")
		end
	end


	def test_query_alerts

		target_ip = "0A.02.C7.EB"  # 10.2.199.235"
		tm_arr = TRPLib::get_available_time(@trp_conn)

		# The Request 
		# ----------
     	req =TRP::Message.new(:trp_command => TRP::Message::Command::ALERT_GROUP_REQUEST)
     	req.alert_group_request =TRP::AlertGroupRequest.new( :context => 0, 
														     :alert_group  => AG_IDS,
															 :source_ip => target_ip,
															 :maxitems  => 1000,
															 :time_interval => TRPLib.mk_time_interval(tm_arr)
														   )

		# The Response
		# ------------
		get_trp_response(@trp_conn,req) do |resp|

			follow_up = TRP::Message.new(:trp_command => TRP::Message::Command::ALERT_ITEM_REQUEST)
			follow_up.alert_item_request = TRP::AlertItemRequest.new(:alert_group  => AG_IDS)
			resp.alert_group_response.alerts.each do |al|
				follow_up.alert_item_request.alert_ids << TRP::AlertID.new(:slice_id => al.slice_id, :alert_id => al.alert_id)
			end

			get_trp_response(@trp_conn,follow_up) do | resp2 |

				  resp=resp2.alert_item_response
				  resolv_candidates = resp.items.collect { |item| [item.source_ip, item.source_port, item.destination_ip, item.destination_port,item.sigid]  }
				  resolv_arr = resolv_candidates.transpose


				  sip_names   = TRPLib::get_labels_for_keys(@trp_conn,CG_HOSTS, resolv_arr[0])
				  sport_names = TRPLib::get_labels_for_keys(@trp_conn,CG_APPS,  resolv_arr[1])
				  dip_names   = TRPLib::get_labels_for_keys(@trp_conn,CG_HOSTS, resolv_arr[2])
				  dport_names = TRPLib::get_labels_for_keys(@trp_conn,CG_APPS,  resolv_arr[3])
				  sigid_names = TRPLib::get_labels_for_keys(@trp_conn,CG_SIGDS, resolv_arr[4])

				  resp.items.each do |item|
							print "#{Time.at(item.time.tv_sec)} "
							print "#{sip_names[item.source_ip]}".ljust(28)
							print "#{sport_names[item.source_port]}".ljust(11)
							print "#{dip_names[item.destination_ip]}".ljust(28)
							print "#{dport_names[item.destination_port]}".ljust(11)
							print "#{sigid_names[item.sigid]}".rjust(10)
							print "\n"
				  end 
			end
		end

	
	end
end


