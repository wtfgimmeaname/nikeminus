require 'rubygems'
require 'fileutils'
require 'json'
require 'curl'
require 'nokogiri'
require 'yajl'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
APP_ROOT = "#{File.dirname(__FILE__)}/.."

require 'nikeminus/data'
require 'nikeminus/storage'
require 'nikeminus/command'

module NikeMinus
  VERSION  = '0.0.1'

  def self.storage
    @storage ||= NikeMinus::Storage.new
  end

  def self.errors
    @errors ||= []
  end
end
