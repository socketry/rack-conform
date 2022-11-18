# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'json'
require 'async/websocket/adapters/rack'

require 'rack/response'

module Rack
	module Conform
		class Application
			def call(env)
				self.public_send(test_method_for(env), env)
			end
			
			def test(env)
				[200, {}, ["Hello World"]]
			end
			
			def test_status(env)
				status = env.fetch('HTTP_STATUS', 200)
				[status.to_i, {}, []]
			end
			
			class EchoWrapper
				def initialize(input)
					@input = input
				end
				
				def each(&block)
					@input.each(&block)
				end
			end
			
			def test_echo(env)
				[200, {}, EchoWrapper.new(env['rack.input'])]
			end
			
			def test_cookies(env)
				cookies = JSON.parse(env['rack.input'].read)
				
				Rack::Response.new.tap do |response|
					cookies.each do |key, value|
						response.set_cookie(key, value)
					end	
				end.finish
			end
			
			def test_headers(env)
				headers = JSON.parse(env['rack.input'].read)
				
				Rack::Response.new.tap do |response|
					headers.each do |key, value|
						Array(value).each do |value|
							response.add_header(key, value)
						end
					end
				end.finish
			end
			
			def test_streaming_hijack(env)
				if env['rack.hijack?']
					callback = proc do |stream|
						stream.write "Hello World"
						stream.close
					end
					
					return [200, {'rack.hijack' => callback}, nil]
				else
					[404, {}, []]
				end
			end
			
			def test_streaming_body(env)
				if Rack::RELEASE >= "3.0"
					callback = proc do |stream|
						stream.write "Hello World"
						stream.close
					end
					
					return [200, {}, callback]
				else
					[404, {}, []]
				end
			end
			
			def test_websocket_echo(env)
				Async::WebSocket::Adapters::Rack.open(env) do |connection|
					while message = connection.read
						connection.write(message)
					end
					connection.close
				end or Protocol::HTTP::Response[404, {}, []]
			end
			
			private
			
			def test_method_for(env)
				parts = env['PATH_INFO'].split('/')
				parts[0] = "test"
				
				return parts.join('_').to_sym
			end
		end
	end
end
