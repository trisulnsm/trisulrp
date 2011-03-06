# Trisul Remote Protocol TRP Demo script
#
# Counter Group Info
#
# Prints information about all supported coutner  groups on a trisul instance
#
require 'trisulrp'

include TrisulRP::Protocol
include TrisulRP::Utils


raise "Usage : cginfo host port" unless ARGV.length==2


TrisulRP::Protocol.connect(ARGV.shift,ARGV.shift,"Demo_Client.crt","Demo_Client.key") do |conn|

    req =TrisulRP::Protocol.mk_request(TRP::Message::Command::COUNTER_GROUP_INFO_REQUEST,
										:counter_group => "{C51B48D4-7876-479E-B0D9-BD9EFF03CE2E}" )

    TrisulRP::Protocol.get_response(conn,req) do |resp|
          resp.group_details.each do |group_detail|
				start_time= Time.at(group_detail.time_interval.from.tv_sec)
				end_time=Time.at(group_detail.time_interval.to.tv_sec)

				p "Name = " + group_detail.name
				p "GUID = " + group_detail.guid

		  end
    end

end 

