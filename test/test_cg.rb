# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'

require './helper'
include TrisulRP::Protocol
include TrisulRP::Keys
include TrisulRP::Utils

class TestTrisulrp < Test::Unit::TestCase

	def test_cg

    target_guid = "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}"

    TrisulRP::Protocol.connect("127.0.0.1",12001,"Demo_Client.crt","Demo_Client.key") do |conn|

    tmarr= TrisulRP::Protocol.get_available_time(conn)
    req =TrisulRP::Protocol.mk_request(TRP::Message::Command::COUNTER_GROUP_REQUEST,
         :counter_group => target_guid,
         :time_interval =>  mk_time_interval(tmarr))

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          p "Counter Group = #{resp.counter_group}"
          p "Meter = #{resp.meter}"
          resp.keys.each do |key|
              p "Details = {Key=>#{key.key},Label=>#{key.label},Volume=>#{key.metric}"
          end
    end
	end

end

end

