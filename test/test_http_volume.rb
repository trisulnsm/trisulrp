require 'trisulrp'


# usage
raise "Usage: test_http_vol.rb TRP-SERVER TRP-PORT" unless ARGV.size==2

# open a connection to Trisul server from command line args
conn  = connect(ARGV[0],ARGV[1],"Demo_Client.crt","Demo_Client.key")
tmarr = get_available_time(conn)

# send request for http ( cg=APPS, key=p-0050) 
# notice use of volumes_only => 1 
req = TrisulRP::Protocol.mk_request(TRP::Message::Command::COUNTER_ITEM_REQUEST,
                                    :counter_group=> CG_APP,
                                    :key=> 'p-0050',
                                    :time_interval => mk_time_interval(tmarr),
									:volumes_only => 1 )

# print totals 
get_response(conn,req) do |resp|
	volume = resp.stats.meters.each do | meter|
	  	print "Meter #{meter.meter} = #{meter.values[0].val}  \n"
	end 
end

