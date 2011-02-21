# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'
require './helper'

include TrisulRP::Protocol

class TestCap < Test::Unit::TestCase


  # get all DNS & SMTP packets in last 1 hour 
  #   	test setup is xff-test.pcap 
  def test_filter_expr

    conn = TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")

	expr = "#{TrisulRP::Guids::CG_APP}=p-0019,p-0035"
	
    tm_arr  = get_available_time(conn)
	tm_arr[0] = tm_arr[1] - 900 

    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST,
							:filter_expression => TRP::FilteredDatagramRequest::ByFilterExpr.new(
									:time_interval  => mk_time_interval(tm_arr), 
									:filter_expression  => expr)
					)

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          fdr=resp.filtered_datagram_response
          p "Number of bytes = #{fdr.num_bytes}\n"
          p "Number of pkts  = #{fdr.num_datagrams}\n"
          p "Hash            = #{fdr.sha1}\n"

          File.open("t.pcap","wb") do |f|
            f.write(fdr.contents)
          end
    end


  end

  def wtest_sess

    target_sess = TRP::SessionID.new(:slice_id => 1, :session_id => 45542)

    conn = TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")


    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST,
							:session  => TRP::FilteredDatagramRequest::BySession.new(
									:session_id  => target_sess)
					)

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          fdr=resp.filtered_datagram_response
          p "Number of bytes = #{fdr.num_bytes}\n"
          p "Number of pkts  = #{fdr.num_datagrams}\n"
          p "Hash            = #{fdr.sha1}\n"

          File.open("t.pcap","wb") do |f|
            f.write(fdr.contents)
          end
    end

  end

  # alert test 
  def test_alert

    target_alert = TRP::AlertID.new(:slice_id => 2, :alert_id => 10133)

    conn = TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")


    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST,
							:alert  => TRP::FilteredDatagramRequest::ByAlert.new(
									:alert_id  => target_alert)
					)

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          fdr=resp.filtered_datagram_response
          p "Number of bytes = #{fdr.num_bytes}\n"
          p "Number of pkts  = #{fdr.num_datagrams}\n"
          p "Hash            = #{fdr.sha1}\n"

          File.open("t.pcap","wb") do |f|
            f.write(fdr.contents)
          end
    end

  end
  #
  # resource test 
  def test_resource

    target = TRP::ResourceID.new(:slice_id => 2, :resource_id => 308)

    conn = TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key")


    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::FILTERED_DATAGRAMS_REQUEST,
							:resource  => TRP::FilteredDatagramRequest::ByResource.new(
									:resource_group => TrisulRP::Guids::RG_DNS,
									:resource_id  => target)
					)

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          fdr=resp.filtered_datagram_response
          p "Number of bytes = #{fdr.num_bytes}\n"
          p "Number of pkts  = #{fdr.num_datagrams}\n"
          p "Hash            = #{fdr.sha1}\n"

          File.open("t.pcap","wb") do |f|
            f.write(fdr.contents)
          end
    end

  end
end




