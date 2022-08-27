# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'async/http/client'
require 'async/http/endpoint'
require 'sus/fixtures/async/reactor_context'

module ClientContext
	include Sus::Fixtures::Async::ReactorContext
	
	def endpoint
		@endpoint ||= Async::HTTP::Endpoint.parse(ENV['RACK_CONFORM_ENDPOINT'])
	end
	
	def client
		@client ||= Async::HTTP::Client.new(endpoint)
	end
end
