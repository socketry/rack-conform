# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

def initialize(...)
	super
	require "sus"
	require "rack/conform/server"
end

def server
	@server = Rack::Conform::Server.current(log: $stdout)
	assertions = Sus::Assertions.new(output: Sus::Output.default)
	@server.start(assertions)
	
	begin
		@server.wait
	rescue Interrupt
		# Ignore.
	end
end
