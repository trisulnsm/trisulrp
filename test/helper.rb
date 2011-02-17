require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'trisulrp'

class Test::Unit::TestCase

  # helper function to get session info and print in a table 
  def print_session_details(conn,sessions)
        all_sids = sessions.collect{ |ai| TRP::SessionID.new(
                     :slice_id => ai.slice_id,
                     :session_id => ai.session_id ) }

        follow_up = TrisulRP::Protocol.mk_request(TRP::Message::Command::SESSION_ITEM_REQUEST,
												  :session_ids => all_sids)

        TrisulRP::Protocol.get_response(conn,follow_up) do |resp|
          resp.session_item_response.items.each do |item|
            print "#{item.session_id.slice_id},#{item.session_id.session_id} "
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

  # convert a string to a key
  def mk_trisul_key(guid,str)
    req = TrisulRP::Protocol.mk_request(TRP::Message::Command::SEARCH_KEYS_REQUEST,
        								  :pattern => str,
										  :counter_group => guid,
										  :maxitems => 1)

    resp = TrisulRP::Protocol.get_response(@conn,req)

	if resp.search_keys_response.found_keys.size > 0 
		resp.search_keys_response.found_keys[0].key
	else
		str
	end
  end

end
