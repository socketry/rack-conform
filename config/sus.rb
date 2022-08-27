# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

def before(assertions)
	if rack_conform_server = ENV['RACK_CONFORM_SERVER']
		@pid = Process.spawn(rack_conform_server)
	end
end

def after(assertions)
	Process.kill(:term, @pid)
end
