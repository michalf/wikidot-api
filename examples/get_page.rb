#!/usr/bin/env ruby
require "rubygems"

$:.unshift(File.dirname(__FILE__) + '/../lib')
require "wikidot_api"

if ARGV.size < 3
  puts "Usage: list_my_sites.rb <api key> <site name> <page name>"
  exit
end

api_key = ARGV[0]
site = ARGV[1]
page = ARGV[2]

wikidot = WikidotAPI::Client.new 'wikidot-api', api_key

page = wikidot.page.get 'site' => site, 'page' => page

puts page['title']
puts page['source']

