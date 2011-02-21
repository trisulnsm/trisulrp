# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'
require './helper'
include TrisulRP::Protocol
include TrisulRP::Guids

class TestTrisulrp < Test::Unit::TestCase

  def setup
    @conn = TrisulRP::Protocol.connect("127.0.0.1",12001,"Demo_Client.crt","Demo_Client.key") 
  end

  def teardown
  end

  def test_flows_for_host

    target_key =  "0A.01.3C.BB"
	
    tmarr  = TrisulRP::Protocol.get_available_time(@conn)

    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST,
        								  :key => target_key ,
										  :time_interval => mk_time_interval(tmarr))

    TrisulRP::Protocol.get_response(@conn,req) do |resp|
		print_session_details(@conn,resp.key_session_activity_response.sessions)
    end

  end

  # test flows for ssh
  # note we need to convert the "ssh" into a key first
  def test_flows_for_appname

    target  =  "ssh"
	target_key =  mk_trisul_key(@conn,CG_APP,target)
	
    tmarr  = TrisulRP::Protocol.get_available_time(@conn)

    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::KEY_SESS_ACTIVITY_REQUEST,
        								  :key => target_key ,
										  :time_interval => mk_time_interval(tmarr))

    TrisulRP::Protocol.get_response(@conn,req) do |resp|
		print_session_details(@conn,resp.key_session_activity_response.sessions)
    end

  end

end


