require './helper'

include TrisulRP::Protocol

class TestTrisulrp < Test::Unit::TestCase

	def test_basic

	    TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt", "Demo_Client.key") do |conn|
			TrisulRP::Protocol.get_available_time(conn)
		end

	end

end
