# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require_relative "conform/version"
require_relative "conform/application"

module Rack
	module Conform
		def self.broken?(feature)
			if defined?(::RACK_CONFORM_BROKEN)
				::RACK_CONFORM_BROKEN.include?(feature)
			else
				false
			end
		end
	end
end
