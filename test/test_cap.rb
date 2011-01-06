# Trisul Remote Protocol TRP Demo script
# Akhil.M & Dhinesh.K (c) 2010 Unleash Networks
# Testing change 
require 'rubygems'
require './helper'
include TrisulRP::Protocol
require 'guidmap'


class TestCap < Test::Unit::TestCase
  def test_dpi
    target_sess = TRP::SessionID.new(:slice_id => 2, :session_id => 207)
    TrisulRP::Protocol.connect("127.0.0.1", 12001,"Demo_Client.crt","Demo_Client.key") do |conn|
      req = TrisulRP::Protocol.mk_request(TRP::Message::Command::SESSION_ITEM_REQUEST,
        :session_ids => [target_sess])
      TrisulRP::Protocol.get_response(conn,req) do |resp|
        si = resp.session_item_response.items[0]
        follow_up = TrisulRP::Protocol.mk_request(:filter_expression  => "#{GUIDMap::SG_TCP}=#{si.session_key}",
                                                  :time_interval => si.time_interval )
        TrisulRP::Protocol.get_response(conn,follow_up) do |resp|
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
  end
end


