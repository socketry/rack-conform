# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require "client_context"
include ClientContext

it "can stream a response" do
	response = client.get("/streaming/hijack")
	
	if response.status == 200
		expect(response.read).to be == "Hello World"
	else
		inform("Streaming hijack not supported!")
	end
ensure
	response&.finish
end
