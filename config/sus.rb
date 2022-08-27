# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'console'
require 'async'
require 'async/http/endpoint'
require 'async/http/client'

def before_tests(assertions)
	if rack_conform_server = ENV['RACK_CONFORM_SERVER']
		@server_pid = wait_for_server_start(assertions, rack_conform_server)
	else
		assertions.inform("Could not identify server!")
	end
	
	super
end

def after_tests(assertions)
	super
	
	if @server_pid
		Process.kill(:INT, @server_pid)
	end
end

private

def wait_for_server_start(assertions, command, timeout: 10)
	clock = Sus::Clock.start!
	log = ::File.open("server.log", "w+")
	pid = Process.spawn(command, out: log, err: log)
	
	Async do
		endpoint = Async::HTTP::Endpoint.parse(ENV['RACK_CONFORM_ENDPOINT'])
		client = Async::HTTP::Client.new(endpoint)
		
		begin
			client.get("/status").finish
		rescue Errno::ECONNREFUSED
			sleep 0.001
			
			if clock.duration > timeout
				assertions.assert(false, "Server did not start within #{timeout} seconds!")
			else
				retry
			end
		end
		
		client.close
	end
	
	assertions.inform("Server started in #{clock}.")
	
	return pid
rescue => error
	Process.kill(:INT, pid) if pid
	raise
ensure
	log&.close
end
