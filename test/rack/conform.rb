# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

it "can echo back request body" do
	response = client.get("/echo", {}, Protocol::HTTP::Body::Buffered.wrap("Hello World"))
	expect(response.status).to be == 200
	expect(response.read).to be == "Hello World"
end
