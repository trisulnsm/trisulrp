$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# =TrisulRP - Trisul Remote Protocol 
# #
# # 
# # Author:: Vivek Rajagopalan
# # Date:: 30 Dec 2010
module TrisulRP
end

require 'rubygems'
require 'trisulrp/trp.pb'
require 'trisulrp/guids.rb'
require 'trisulrp/keys.rb'
require 'trisulrp/protocol.rb'
require 'trisulrp/utils.rb'
