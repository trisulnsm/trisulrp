# Trisul Remote Protocol TRP Demo script
require 'rubygems'
require './helper'
include TrisulRP::Protocol
include TrisulRP::Keys
include TrisulRP::Utils

class TestTrisulrp < Test::Unit::TestCase

  def test_keys
    print "0A.01.3C.BB = " 
	print TrisulRP::Keys::make_readable( "0A.01.3C.BB" )
	print  "\n"

	print "10.1.60.187 = " 
	print TrisulRP::Keys::make_key( "10.1.60.187" )
	print  "\n"

	print "p-01BB = "
	print TrisulRP::Keys::make_readable( "p-01BB" )
	print  "\n"

	print "Port-443 =  " 
	print TrisulRP::Keys::make_key( "Port-443" )
	print  "\n"

  end


  def test_resolved

    conn = TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")


    print "www.wireshark.org  = " 
	print TrisulRP::Utils::mk_trisul_key( conn, TrisulRP::Guids::CG_HOST, "www.wireshark.org"  )
	print  "\n"


	print "80.79.32.7A = " 
	print TrisulRP::Keys::make_readable( "80.79.32.7A" )
	ip = TrisulRP::Keys::make_readable("128.121.50.122" )
	print  "\n"

	print "128.121.50.122 = "
	print TrisulRP::Keys::make_key("128.121.50.122" )
	print  "\n"


	# back to ip 
	print "from ip to key "
    print "#{ip}   = " 
	print TrisulRP::Utils::mk_trisul_key( conn, TrisulRP::Guids::CG_HOST, ip  )
	print  "\n"
	

  end


end


