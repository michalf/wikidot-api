require "rubygems"
require "xmlrpc/client"
require "cgi"

# Enable NIL extension to handle <nil/> values
XMLRPC::Config::ENABLE_NIL_CREATE = true
XMLRPC::Config::ENABLE_NIL_PARSER = true

$: << File.dirname(__FILE__)

require "wikidot_api/version"
require "wikidot_api/client"