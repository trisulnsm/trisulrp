# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './helper'
include TrisulRP::Protocol
require guidmap
class TestTrisulrp < Test::Unit::TestCase

	def test_query_alerts

    target_ip = "0A.02.C7.EB"  # 10.2.199.235"
    TrisulRP::Protocol.connect("127.0.0.1",12001,"Demo_Client.crt","Demo_Client.key") do |conn|
      tm_arr = TrisulRP::Protocol.get_available_time(conn)
      req =TrisulRP::Protocol.mk_request(:context => 0,:alert_group  =>TrisulRP::Guids::AG_IDS,												       :source_ip => target_ip,
        :maxitems  => 1000,
        :time_interval => TRPLib.mk_time_interval(tm_arr))

      TrisulRP::Protocol.get_response(conn,req) do |resp|
        follow_up = TrisulRP::Protocol.mk_request(:alert_group  => TrisulRP::Guids::AG_IDS)
		    resp.alert_group_response.alerts.each do |al|
          follow_up.alert_item_request.alert_ids << TRP::AlertID.new(:slice_id => al.slice_id, :alert_id => al.alert_id)
		    end

		    TrisulRP::Protocol.getresponse(conn,follow_up) do | resp2 |
          resp=resp2.alert_item_response
          resolv_candidates = resp.items.collect { |item| [item.source_ip, item.source_port, item.destination_ip, item.destination_port,item.sigid]  }
          resolv_arr = resolv_candidates.transpose
          sip_names   = TrisulRP::Protocol.get_labels_for_keys(conn,TrisulRP::Guids::CG_HOSTS, resolv_arr[0])
          sport_names = TrisulRP::Protocol.get_labels_for_keys(conn,TrisulRP::Guids::CG_APPS,  resolv_arr[1])
          dip_names   = TrisulRP::Protocol.get_labels_for_keys(conn,TrisulRP::Guids::CG_HOSTS, resolv_arr[2])
          dport_names = TrisulRP::Protocol.get_labels_for_keys(conn,TrisulRP::Guids::CG_APPS,  resolv_arr[3])
          sigid_names = TrisulRP::Protocol.get_labels_for_keys(conn,TrisulRP::Guids::CG_SIGDS, resolv_arr[4])
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
end

