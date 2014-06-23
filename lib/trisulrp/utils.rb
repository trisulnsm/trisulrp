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
  # [sessions]           an array of SessionIDs or 
  # 					 an array of slice:sid strings 
  #
  # ==== Returns
  # ==== Yields
  # Nothing 
  #
  # Prints details about the list of sessions (flows) passed 
  #
  # ==== On error
  def print_session_ids(conn,sessions)
    all_sids = sessions.collect{ |ai| TRP::SessionID.new(
                 :slice_id => ai.slice_id,
                 :session_id => ai.session_id ) }

    follow_up = TrisulRP::Protocol.mk_request(TRP::Message::Command::SESSION_ITEM_REQUEST,
                      :session_ids => all_sids)

    TrisulRP::Protocol.get_response(conn,follow_up) do |resp|
      resp.items.each do |item|
	  	print_session_details(item)
      end
    end
  end


  # Print a SessionDetails object 
  #
  # Use this to output session to screen 
  #
  # [sess]           a single SessionDetails object 
  #
  # ==== Returns
  # ==== Yields
  # Nothing 
  #
  # Pretty prints a single line session details 
  #
  # ==== On error
  def print_session_details(sess)
	print "#{sess.session_id.slice_id}:#{sess.session_id.session_id} ".ljust(12)
	print "#{Time.at(sess.time_interval.from.tv_sec)} ".ljust(26)
	print "#{sess.time_interval.to.tv_sec-sess.time_interval.from.tv_sec} ".rjust(8)
	print "#{sess.key1A.label}".ljust(28)
	print "#{sess.key2A.label}".ljust(11)
	print "#{sess.key1Z.label}".ljust(28)
	print "#{sess.key2Z.label}".ljust(11)
	print "#{sess.az_bytes}".rjust(10)
	print "#{sess.za_bytes}".rjust(10)
	print "#{sess.az_payload}".rjust(10)
	print "#{sess.za_payload}".rjust(10)
	print "#{sess.setup_rtt}".rjust(10)
	print "#{sess.retransmissions}".rjust(10)
	print "#{sess.tags}".rjust(10)
	print "\n"

  end


  # Print the header column for sess details 
  #
  # Use this to output session to screen 
  #
  #
  # ==== Returns
  # ==== Yields
  # Nothing 
  #
  # Pretty prints a single line session details header w/ correct col widths
  #
  # ==== On error
  def print_session_details_header
	print "SID".ljust(12)
	print "Start Time".ljust(26)
	print "Dur ".rjust(8)
	print "IP-A".ljust(28)
	print "Port-A".ljust(11)
	print "IP-Z".ljust(28)
	print "Port-Z".ljust(11)
	print "Fwd Bytes".rjust(10)
	print "Rev Bytes".rjust(10)
	print "Fwd Payld".rjust(10)
	print "Rev Payld".rjust(10)
	print "RTT".rjust(10)
	print "Retrans".rjust(10)
	print "Tags".rjust(10)
	print "\n"

	print "-"*11 + "+" 
	print "-"*25 + "+" 
	print "-"*7 + "+" 
	print "-"*27 + "+" 
	print "-"*10 + "+" 
	print "-"*27 + "+" 
	print "-"*10 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "-"*9 + "+" 
	print "\n"
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
  # [str]        eg a resolved name (eg a host like www.blue.net)
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

    return if alerts.empty?

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
