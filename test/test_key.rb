# Trisul Remote Protocol TRP Demo script
require 'rubygems'
require './helper'
include TrisulRP::Protocol
include TrisulRP::Keys

class TestTrisulrp < Test::Unit::TestCase

  def test_keys
    p "0A.01.3C.BB = " 
	p TrisulRP::Keys::make_readable( "0A.01.3C.BB" )

	p "10.1.60.187 = " 
	p TrisulRP::Keys::make_key( "10.1.60.187" )

	p "p-01BB = "
	p TrisulRP::Keys::make_readable( "p-01BB" )

	p "Port-443 =  " 
	p TrisulRP::Keys::make_key( "Port-443" )

  end


end


