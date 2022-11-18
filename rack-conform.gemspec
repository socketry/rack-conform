# frozen_string_literal: true

require_relative "lib/rack/conform/version"

Gem::Specification.new do |spec|
	spec.name = "rack-conform"
	spec.version = Rack::Conform::VERSION
	
	spec.summary = "An implementation of the Rack protocol/specification."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/socketry/rack-conform"
	
	spec.files = Dir.glob(['{lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 2.5"
	
	spec.add_dependency "async-http", "~> 0.50"
	spec.add_dependency "async-websocket"
	spec.add_dependency "benchmark-http", "~> 0.2"
	spec.add_dependency "rack", ">= 1.0"
	spec.add_dependency "sus", "~> 0.12"
	spec.add_dependency "sus-fixtures-async", "~> 0.1.0"
end
