require 'rubygems'
require 'curl'
require 'nokogiri'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'nikeminus/xml'
require 'nikeminus/user'

module NikeMinus
  def self.user_id
    @storage ||= NikeMinus::Storage.new
  end
end
