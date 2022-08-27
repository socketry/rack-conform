# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'console'
require 'async'
require 'async/http/endpoint'
require 'async/http/client'

def before_tests(assertions)
	if rack_conform_server = ENV['RACK_CONFORM_SERVER']
		Console.logger.info(self, "Starting server...")
		@server_pid = wait_for_server_start(rack_conform_server)
	else
		Console.logger.info(self, "Could not identify server", env: env)
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

def wait_for_server_start(command, timeout: 10)
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
				raise "Server did not start within #{timeout} seconds!"
			else
				retry
			end
		end
		
		client.close
	end
	
	Console.logger.info(self, "Server started in #{clock}.")
	
	return pid
rescue => error
	Console.logger.error(self, "Server failed to start:", error)
	Process.kill(:INT, pid) if pid
	
	if log
		log.seek(0)
		Console.logger.error(self, log.read)
	end
	
	raise
ensure
	log&.close
end
