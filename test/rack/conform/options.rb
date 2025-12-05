# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require "rack/conform"

require "client_context"
include ClientContext

require "protocol/http/request"

it "can handle OPTIONS / request" do
	request = Protocol::HTTP::Request.new(
		endpoint.scheme, endpoint.authority, "OPTIONS", "/", nil, Protocol::HTTP::Headers.new, nil
	)
	
	response = client.call(request)
	expect(response.status).to be == 200
	expect(response.read).to be == "OPTIONS /"
ensure
	response&.finish
end

it "can handle OPTIONS * request" do
	skip("Unsuppported by server!") if ::Rack::Conform.broken?(:options_star)
	
	request = Protocol::HTTP::Request.new(
		endpoint.scheme, endpoint.authority, "OPTIONS", "*", nil, Protocol::HTTP::Headers.new, nil
	)
	
	response = client.call(request)
	expect(response.status).to be == 200
	if ::Rack::RELEASE > "3.2"
		expect(response.read).to be == "OPTIONS *"
	else
		expect(response.read).to be(:start_with?, "OPTIONS")
	end
ensure
	response&.finish
end
