# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './helper'
include TrisulRP::Protocol
include TrisulRP::Keys

class TestTrisulrp < Test::Unit::TestCase

	def test_query_alerts

    target_ip = "10.1.10.10"  # 10.2.199.235"

    TrisulRP::Protocol.connect("127.0.0.1",12001,"Demo_Client.crt","Demo_Client.key") do |conn|
	
      tm_arr = TrisulRP::Protocol.get_available_time(conn)

      req =TrisulRP::Protocol.mk_request(TRP::Message::Command::ALERT_GROUP_REQUEST,
	  									:alert_group  =>TrisulRP::Guids::AG_IDS,
										:source_ip => TrisulRP::Keys.make_key(target_ip),
										:maxitems  => 1000,
										:time_interval => mk_time_interval(tm_arr))

      TrisulRP::Protocol.get_response(conn,req) do |resp|
	  	print_alert_details(conn,resp.alert_group_response.alerts)
      end
    end
  end
end

