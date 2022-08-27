# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

module Rack
	module Conform
		class Server
			def call(env)
				self.public_send(test_method_for(env), env)
			end
			
			def echo(env)
				[200, {}, env['rack.input']]
			end
			
			private
			
			def test_method_for(env)
				env['PATH_INFO'].split('/')[1..].join('_').to_sym
			end
		end
	end
end
