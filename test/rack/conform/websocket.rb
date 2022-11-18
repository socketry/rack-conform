# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

require 'async/websocket/client'
let(:websocket_client) {Async::WebSocket::Client.open(endpoint)}

require 'rack'

if Rack::RELEASE > "3.0"
	it 'can establish a websocket connection' do
		connection = websocket_client.connect(endpoint.authority, "/websocket/echo")
		
		begin
			connection.send_text("Hello World")
			message = connection.read
			expect(message).to be == "Hello World"
		ensure
			connection.close
		end
	end
end
