
# Trisul Remote Protocol TRP Demo script
require 'rubygems'
require './helper'
include TrisulRP::Protocol
include TrisulRP::Keys

class TestTrisulrp < Test::Unit::TestCase

  def test_grep

	
    conn=TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")
	
	avail_tm  = TrisulRP::Protocol.get_available_time(conn)

    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::GREP_REQUEST,
										:time_interval => mk_time_interval(avail_tm),
										:maxitems => 4,
										:pattern => "HELO footballbat2.usma.bluenet")


    TrisulRP::Protocol.get_response(conn,req) do |resp|

		print_session_details(conn,resp.sessions)

    end

  end
end

