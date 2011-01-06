# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'
require './helper'
include TrisulRP::Protocol
require guidmap

class TestTrisulrp < Test::Unit::TestCase
  def test_flows_for_host

    target_key =  "0A.01.3C.BB"
		TrisulRP::Protocol.connect("127.0.0.1",12001,"Demo_Client.crt","Demo_Client.key") do |conn|
      
      tmarr  = TrisulRP::Protocol.get_available_time(conn)

      req = TrisulRP::Protocol.mk_request(TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST,
        :key => target_key ,:time_interval =>TrisulRP::Protocol.mk_time_interval(tmarr))
      TrisulRP::Protocol.get_response(conn,req) do |resp|
        all_sids = resp.key_session_activity_response.sessions.collect{ |ai| TRP::SessionID.new(
                     :slice_id => ai.slice_id,
                     :session_id => ai.session_id ) }

        follow_up = TrisulRP::Protocol.mk_request(:session_ids => all_sids)
        TrisulRP::Protocol.get_response(conn,follow_up) do |resp|
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
end


