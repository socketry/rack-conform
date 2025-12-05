# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require "client_context"
include ClientContext

it "has REQUEST_PATH set correctly" do
	response = client.get("/env?key=REQUEST_PATH")
	expect(response.status).to be == 200
	
	body = JSON.parse(response.body.read)
	expect(body).to be == "/env"
ensure
	response&.finish
end
