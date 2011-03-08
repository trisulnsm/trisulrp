# == Keys - Utilities to convert a key to a human readable string & back
#
module TrisulRP::Keys

class Null
    def self.xform(kstring)
        yield kstring if block_given?
        kstring
    end
end

class HNumber
    # key to human string
    # => width unused
    # => kstring = hex number like A011
    # output is a decimal number
    def self.xform(kstring)
        ret = kstring.hex.to_s
        yield ret if block_given?
        ret
    end

    # human string to key
    # => width padding eg to output 000B when input = 11 and field is a 2 byte
    # => dstring input decimal
    def self.invert_xform(width,dstring)
        ret = dstring.to_i.to_s(16).rjust(width,"0").upcase
        yield ret if block_given?
        ret
    end

    # is_key_pattern?
    def self.is_key_form? patt
		return false if patt.nil?
        [2,4,8].member? patt.length and patt =~ /(\d|[a-f]|[A-F])+/
    end

    # is_human_pattern?
    def self.is_human_form? patt
      patt.to_i > 0 or patt.squeeze("0") == "0"
    end
end


class Host
    # key to human string
    def self.xform(kstring)
        ret = kstring.split('.').collect { |hexbyte| hexbyte.hex.to_s }.join('.')
        yield ret if block_given?
        ret
    end

    # human string to key
    def self.invert_xform(dstring)
        ret = dstring.split('.').collect { |decbyte| decbyte.to_i.to_s(16).rjust(2,"00").upcase}.join('.')
        yield ret if block_given?
        ret
    end

    # is_key_pattern?
    def self.is_key_form? patt
		return false if patt.nil?
      patt.length == 11 and (patt[2] == "." || patt[5] == "." || patt[8] == ".")
    end

    # is_human_pattern?
    def self.is_human_form? patt
      patt.split('.').select { |szbyte| (1..255).cover?(szbyte.to_i) or szbyte.squeeze("0") == "0" }.size == 4
    end
end

  # UDP/TCP port a 2 byte number
class Port

    # key to human string
    def self.xform(kstring)
          s =  "Port-" + kstring[2..-1].hex.to_s
          yield s if block_given?
          return s
    end

    # human string to key
    # handles formats
    # => Port-80
    # => port-80
    # => 80
    def self.invert_xform(dstring)
      if dstring.size > 5 and dstring[0..4].upcase == "PORT-"
          return "p-"+dstring.slice(5..-1).to_i.to_s(16).rjust(4,"0000").upcase
      else
          return "p-"+dstring.to_i.to_s(16).rjust(4,"0000").upcase
      end
    end

    # is_key_form?
    def self.is_key_form? patt
		return false if patt.nil?
      patt.length == 6 and patt[0] == 'p' and patt[1] == '-'
    end

    # is_human_form?
    def self.is_human_form? patt
      patt[0..4].upcase == "PORT-" and ((1..65535).include? patt[5..-1].to_i)
    end
end

class Subnet
    # key to human string
    # => key - 00.00.00.00_8888
    def self.xform(kstring)
        parts=kstring.split('/')
        ret = Host.xform(parts[0]) + "/" + HNumber.xform(parts[1])
        yield ret if block_given?
        ret
    end

    # human string to key
    def self.invert_xform(dstring)
        parts=dstring.split('/')
        ret = Host.invert_xform(parts[0]) + "/" + HNumber.invert_xform(2,parts[1])
        yield ret if block_given?
        ret
    end

    # is_key_pattern?
    def self.is_key_form? patt
	  return false if patt.nil?
      parts = patt.split('/')
      parts.size == 2 and Host.is_key_form?(parts[0]) and HNumber.is_key_form?(parts[1])
    end

    # is_human_pattern?
    def self.is_human_form? patt
      parts = patt.split('/')
      parts.size == 2 and Host.is_human_form?(parts[0]) and HNumber.is_human_form?(parts[1])
    end
end


class HostInterface
    # key to human string
    # => key - 00.00.00.00/10
    def self.xform(kstring)
        parts=kstring.split('_')
        ret = Host.xform(parts[0]) + "_" + HNumber.xform(parts[1])
        yield ret if block_given?
        ret
    end

    # human string to key
    def self.invert_xform(dstring)
        parts=dstring.split('_')
        ret = Host.invert_xform(parts[0]) + "_" + HNumber.invert_xform(4,parts[1])
        yield ret if block_given?
        ret
    end

    # is_key_pattern?
    def self.is_key_form? patt
	  return false if patt.nil?
      parts = patt.split('_')
      parts.size == 2 and Host.is_key_form?(parts[0]) and HNumber.is_key_form?(parts[1])
    end

    # is_human_pattern?
    def self.is_human_form? patt
      parts = patt.split('_')
      parts.size == 2 and Host.is_human_form?(parts[0]) and HNumber.is_human_form?(parts[1])
    end
end

  # key and human form are same
class ASNumber
    # key to human string
    # => key - ASnnn
    def self.xform(kstring)
        yield kstring if block_given?
        kstring
    end

    # human string to key
    def self.invert_xform(dstring)
        yield dstring if block_given?
        dstring
    end

    # is_key_pattern?
    def self.is_key_form? patt
      return false if patt.nil?
      patt[0..1]=="AS"
    end

    # is_human_pattern?
    def self.is_human_form? patt
      return false if patt.nil?
      patt[0..1]=="AS"
    end
end

	# convert a trisul key format into a human readable key 
	# [keyform]  the key form
	#
	# ==== Typical use 
	#
	# Used to convert an IP / Port or any other trisul key into a readable form
	#
	# <code>
	#
	#   make_readable("C0.A8.0C.A0") => "192.168.12.160"
	#
	#   make_readable("p-0016") => "Port-22"
	#
	# </code>
	#
	#
	#
	# Also see TrisulRP::Protocol::get_labels_for_keys to obtain a text name for the key
	#
	# Also see the inverse of this method make_key which convert a readable string into a key 
	# suitable for use in TRP request messages. 
	#
	# If key type cannot be accurately guessed it returns the input 
	#
	def make_readable(keyform)
		[ TrisulRP::Keys::Port,
		  TrisulRP::Keys::Host,
		  TrisulRP::Keys::HostInterface,
		  TrisulRP::Keys::Subnet,
		  TrisulRP::Keys::ASNumber
		].each do |kls|
			return kls.xform(keyform) if kls.is_key_form?(keyform)
		end
		return keyform
	end


	# convert a key in human form into trisul key format
	#
	# [humanform]  the human  form of the key 
	#
	# ==== Typical use 
	#
	# Used to convert a human form key into a Trisul Key format suitable for use with TRP requests
	#
	#
	# <code>
	#
	#   make_key("192.168.1.1") => "C0.A8.01.01"
	#
	# </code>
	#
	#
	# Also see the inverse of this method make_readable 
	#
	#
	def make_key(readable)
		[ TrisulRP::Keys::Port,
		  TrisulRP::Keys::Host,
		  TrisulRP::Keys::HostInterface,
		  TrisulRP::Keys::Subnet,
		  TrisulRP::Keys::ASNumber
		].each do |kls|
			return kls.invert_xform(readable) if kls.is_human_form?(readable) 
		end
		return readable
	end


    # convert a set of keys into labels
	#
	# This method accepts an array of keys (which are references to counter items in Trisul) and sends
	# a key lookup request to Trisul.  Trisul responds with labels for those keys that had labels. Finally a 
	# ready to use map is constructed and returned to the caller.
	#
	# [conn]    a TRP connection opened earlier via connect(..) 
	# [cgguid]  a counter group id. See TrisulRP::Guids for a list of common guids 
	# [key_arr] an array of keys, possibly obtained as a result of an earlier command
	#
	# ==== Returns
	# a hash of Key => Label. All keys in the incoming array will have a hash entry. If Trisul could not
	# find a label for a key, it will store the key itself as the hash value.
	#
	# ==== Typical usage 
	#
	# You use this method as a bulk resolving mechanism. 
	# <code>
	#
	#  host_keys = ["0A.0A.18.E0", "B1.01.8F.01",...]
    #  host_names   = TrisulRP::Protocol.get_labels_for_keys(conn,
	#                       TrisulRP::Guids::CG_HOSTS, host_keys)
	#
	#  host_names["0A.0A.18.E0"] = "demo.trisul.org"   # ok 
	#  host_names["B1.01.8F.01"] = "B1.01.8F.01"       # no label for this key
	#
	# </code>
	#
	def get_labels_for_keys(conn, cgguid, key_arr)
		req = mk_request(TRP::Message::Command::KEY_LOOKUP_REQUEST,
		  :counter_group  => cgguid, :keys => key_arr.uniq )
		h = key_arr.inject({}) { |m,i| m.store(i,make_readable(i)); m }
		get_response(conn,req) do |resp|
				resp.key_details.each { |d| h.store(d.key,d.label) }
		end
		return h
	  end

end
