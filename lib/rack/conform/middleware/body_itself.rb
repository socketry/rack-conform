# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Earlopain.

module Rack
	module Conform
		module Middleware
			class BodyItself
				def initialize(app)
					@app = app
				end
				
				def each
					yield "Hello World"
				end
				
				def call(env)
					[200, {}, self]
				end
			end
		end
	end
end
