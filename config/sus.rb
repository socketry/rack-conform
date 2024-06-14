# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require 'rack/conform/server'

def before_tests(assertions)
	@server = Rack::Conform::Server.current
	@server&.start(assertions)
	
	super
end

def after_tests(assertions)
	super
	
	@server&.close
end
