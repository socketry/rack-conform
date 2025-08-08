# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require "console"
require "async"
require "async/http/endpoint"
require "async/http/client"

module Rack
	module Conform
		class Server
			def self.current(**options)
				command = ENV["RACK_CONFORM_SERVER"]
				endpoint = ENV["RACK_CONFORM_ENDPOINT"]
				
				if command and endpoint
					return self.new(command, endpoint, **options)
				end
			end
			
			def initialize(command, endpoint, log: nil)
				@command = command
				@endpoint = endpoint
				@log = log
				
				@pid = nil
			end
			
			def log
				@log ||= ::File.open("server.log", "w+")
			end
			
			def print(output)
				output.write "server ", :variable, @command.inspect, " ", @endpoint, :reset
			end
			
			def start(assertions)
				raise "Already started!" if @pid
				
				assertions.nested(self, isolated: true, measure: true) do |assertions|
					assertions.inform("Starting server...")
					@pid = self.startup(assertions)
				end
			end
			
			def wait
				if @pid
					Process.wait(@pid)
				end
			end
			
			def close
				if @pid
					Process.kill(:INT, @pid)
				end
			end
			
			private
			
			def startup(assertions, timeout: 10)
				clock = Sus::Clock.start!
				log = self.log
				pid = Process.spawn(@command, out: log, err: log)
				
				Async do
					endpoint = Async::HTTP::Endpoint.parse(ENV["RACK_CONFORM_ENDPOINT"])
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
			end
		end
	end
end
