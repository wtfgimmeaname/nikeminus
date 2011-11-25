#!/usr/bin/ruby
require 'rubygems'
require 'curl'
require 'nokogiri'

class FetchNikeXml
  NIKESERVER   = "http://nikerunning.nike.com"
  NIKEFILEPATH = "/nikeplus/v1/services/widget/get_public_run_list.jsp"
  NIKEURLPARAM = "?userID="

  def assistant
    puts "Do you have your Nike+ ID? (y/n)"
    if gets.chomp == 'y'
      puts "Great. Paste it here:"
      nike_id = validate_nike_id(gets.chomp)
      puts "-----------------------------------"
      puts "Invalid ID. Double check the README." unless nike_id

      xml = get_nike_xml(nike_id)
      validate_nike_xml(xml)
    else
      puts "Please go through the README.txt to find yours"
    end
  end

  def validate_nike_xml(xml)
    xml_doc = Nokogiri::XML(xml)
    status  = xml_doc.xpath("//plusService//status").text
    puts "\nDocument returned with status -- #{status.upcase} --"
    if status.include? "failure"
      error_msg = xml_doc.xpath("//plusService//serviceException").text
      return puts " -- Error: #{error_msg} --\n"
    end
  end

  def get_nike_xml(nike_id)
    url = NIKESERVER+NIKEFILEPATH+NIKEURLPARAM+nike_id
    puts "Getting your public Nike data from: #{url}" 
    quickPause

    begin
      c = Curl::Easy.perform(url)
      puts " successful respsone from Nike."
      return c.body_str
    rescue Curl::Err::HostResolutionError => e
      puts "There was an error with the Url."
      puts "Please contact github.com/dustinweatherford and tell him"
      puts "Sorry."
    end
  end

  def validate_nike_id(nike_id)
    haystack = %r{^[0-9]+$}
    nike_id.match(haystack) ? nike_id : nil
  end

  def quickPause
    i = 0
    while i < 20
      print(".")
      sleep(rand(0.1/2)/8)
      i += 1
    end
  end
end

nf = FetchNikeXml.new
nf.assistant
