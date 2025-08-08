# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Earlopain.

require "client_context"
include ClientContext

require "rack"

it "can handle a middleware that returns itself as the body" do
	response = client.get("/middleware/body/itself")
	
	expect(response.status).to be == 200
	expect(response.read).to be == "Hello World"
ensure
	response&.finish
end
