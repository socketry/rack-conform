# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require "client_context"
include ClientContext

require "rack"

if Rack::RELEASE > "3.0"
	it "can stream a response" do
		response = client.get("/streaming/body")
		
		expect(response.status).to be == 200
		expect(response.read).to be == "Hello World"
	ensure
		response&.finish
	end
end
