# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

def before_tests(assertions)
	if rack_conform_server = ENV['RACK_CONFORM_SERVER']
		Console.logger.info(self, "Starting server...")
		@server_pid = wait_for_server_start(rack_conform_server)
	else
		Console.logger.info(self, "Could not identify server", env: env)
	end
end

def after_tests(assertions)
	if @server_pid
		Process.kill(:INT, @server_pid)
	end
end

private

def wait_for_server_start(command, timeout: 10)
	clock = Sus::Clock.start!
	pid = Process.spawn(command)
	
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
rescue
	Process.kill(:INT, pid) if pid
	raise
end
