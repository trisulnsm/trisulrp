# = TrisulRP utility  methods 
# 
# == Contains utility to print objects like flows, alerts
#    and to resolve keys etc
#

# ==== TrisulRP::Utils
#
# Utility methods to help with 
# * retrieving and printing objects
# * prints sessions / alerts if given an array of IDs
# * helper to resolve a key 
# 
# 
module TrisulRP::Utils

	# Print session (flow) details 
	#
	# [conn]               active TRP connection opened earlier 
	# [sessions]           an array of SessionIDs
	#
	# ==== Returns
	# ==== Yields
	# Nothing 
	#
	# Prints details about the list of sessions (flows) passed 
	#
	# ==== On error
	def print_session_details(conn,sessions)
        all_sids = sessions.collect{ |ai| TRP::SessionID.new(
                     :slice_id => ai.slice_id,
                     :session_id => ai.session_id ) }

        follow_up = TrisulRP::Protocol.mk_request(TRP::Message::Command::SESSION_ITEM_REQUEST,
												  :session_ids => all_sids)

        TrisulRP::Protocol.get_response(conn,follow_up) do |resp|
          resp.items.each do |item|
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

	# Make key
	#
	# Convert an item into Trisul Key format. 
	#
	# Example 
	#
	# == Pass a hostname 
	# mk_trisul_key(conn,GUID_HOSTS,"www.trisul.org") => "D0.D1.01.EA"
	# mk_trisul_key(conn,GUID_APPS,"https") => "p-01BB"
	#
	# == Pass a IP 
	# mk_trisul_key(conn,GUID_HOSTS,"192.168.1.5") => "C0.A8.01.05"
	# mk_trisul_key(conn,GUID_APPS,"Port-443") => "p-01BB"
	#
	#
	# [conn]           active TRP connection opened earlier 
	# [guid]           counter group id (eg hosts, apps, countries)
	# [str]			   eg a resolved name (eg a host like www.blue.net)
	#
	# ==== Returns
	# A string containing the key in Trisul format corresponding to the
	# label passed in via ''str'' 
	#
	# ==== Yields
	# Nothing 
	#
	# ==== On error
	def mk_trisul_key(conn,guid,str)
    	req = TrisulRP::Protocol.mk_request(TRP::Message::Command::SEARCH_KEYS_REQUEST,
        								  :pattern => str,
										  :counter_group => guid,
										  :maxitems => 1)

    	resp = TrisulRP::Protocol.get_response(conn,req)

		if resp.found_keys.size > 0 
			resp.found_keys[0].key
		else
			TrisulRP::Keys::make_key(str)
		end
  end

	# Print alert details 
	#
	# [conn]               active TRP connection opened earlier 
	# [alerts]             an array of AlertIDs
	#
	# ==== Returns
	# ==== Yields
	# Nothing 
	#
	# Prints details about the list of alerts passed 
	#
	# ==== On error
   def print_alert_details(conn, alerts)

    p "No alerts found " and return if alerts.empty?

	# retrieve details of alerts from server 
       follow_up = TrisulRP::Protocol.mk_request(TRP::Message::Command::ALERT_ITEM_REQUEST,
					:alert_group  => TrisulRP::Guids::AG_IDS,
	    			:alert_ids    => alerts.collect do |al| 
										TRP::AlertID.new(:slice_id => al.slice_id, 
										:alert_id => al.alert_id)
									 end
				)



	TrisulRP::Protocol.get_response(conn,follow_up) do | resp |
         resolv_candidates = resp.items.collect { |item| [item.source_ip, item.source_port, item.destination_ip, item.destination_port,item.sigid]  }
         resolv_arr = resolv_candidates.transpose
         sip_names   = TrisulRP::Keys.get_labels_for_keys(conn,TrisulRP::Guids::CG_HOST, resolv_arr[0])
         sport_names = TrisulRP::Keys.get_labels_for_keys(conn,TrisulRP::Guids::CG_APP,  resolv_arr[1])
         dip_names   = TrisulRP::Keys.get_labels_for_keys(conn,TrisulRP::Guids::CG_HOST, resolv_arr[2])
         dport_names = TrisulRP::Keys.get_labels_for_keys(conn,TrisulRP::Guids::CG_APP,  resolv_arr[3])
         sigid_names = TrisulRP::Keys.get_labels_for_keys(conn,TrisulRP::Guids::CG_ALERT_SIGNATURES, resolv_arr[4])
         resp.items.each do |item|
           print "#{Time.at(item.time.tv_sec)} "
           print "#{sip_names[item.source_ip]}".ljust(28)
           print "#{sport_names[item.source_port]}".ljust(11)
           print "#{dip_names[item.destination_ip]}".ljust(28)
           print "#{dport_names[item.destination_port]}".ljust(11)
           print "#{sigid_names[item.sigid]}".rjust(10)
           print "\n"
         end
   end
 end
end
