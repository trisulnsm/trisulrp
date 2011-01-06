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

end
