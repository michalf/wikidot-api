#!/usr/bin/env ruby
require "rubygems"

$:.unshift(File.dirname(__FILE__) + '/../lib')
require "wikidot_api"

if ARGV.size < 2
  puts "Usage: list_my_sites.rb <api key> <user name>"
  exit
end

api_key = ARGV[0]
user_name = ARGV[1]

wikidot = WikidotAPI::Client.new 'wikidot-api', api_key
sites = wikidot.user.sites 'user' => user_name

sites.each do |site|
  puts "#{site["title"]}, http://#{site["name"]}.wikidot.com" 
end