$LOAD_PATH.unshift 'lib'
require 'wikidot_api/version'

Gem::Specification.new do |s|
  s.name              = "wikidot-api"
  s.version           = WikidotAPI::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Simple Ruby client library for Wikidot RPC API"
  s.homepage          = "http://github.com/michalf/wikidot-api"
  s.email             = "michalf@wikidot.com"
  s.authors           = [ "Michał Frąckowiak" ]

  s.files             = %w( README.md LICENSE )
  s.files            += Dir.glob("lib/**/*")
  # s.files            += Dir.glob("bin/**/*")
  # s.files            += Dir.glob("man/**/*")
  # s.files            += Dir.glob("spec/**/*")
  # s.files            += Dir.glob("tasks/**/*")
  # s.executables       = []

  s.extra_rdoc_files  = [ "LICENSE", "README.md" ]
  s.rdoc_options      = ["--charset=UTF-8"]
  
  s.description = <<description
Simple Ruby client library for Wikidot RPC API
description

end
