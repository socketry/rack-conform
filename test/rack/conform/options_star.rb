# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require "client_context"
include ClientContext

require "protocol/http/request"

it "can handle OPTIONS * request" do
	request = Protocol::HTTP::Request.new(
		endpoint.scheme, endpoint.authority, "OPTIONS", "*", nil, Protocol::HTTP::Headers.new, nil
	)
	
	response = client.call(request)
	expect(response.status).to be == 200
	expect(response.read).to be == "OPTIONS *"
ensure
	response&.finish
end
