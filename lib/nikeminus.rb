require 'rubygems'
require 'curl'
require 'json'
require 'nokogiri'
require 'yajl'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'nikeminus/data'
require 'nikeminus/user'
require 'nikeminus/storage'
require 'nikeminus/command'

module NikeMinus
  VERSION = '0.0.1'

  def self.storage
    @storage ||= NikeMinus::Storage.new
  end
end
