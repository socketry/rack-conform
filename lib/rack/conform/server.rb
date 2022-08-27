# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

module Rack
	module Conform
		class Server
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
			
			def test_echo(env)
				[200, {}, env['rack.input']]
			end
			
			def test_headers(env)
				headers = JSON.parse(env['rack.input'].read)
				[200, headers, []]
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
