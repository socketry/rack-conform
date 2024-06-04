# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

with 'response headers' do
	def body(headers)
		Protocol::HTTP::Body::Buffered.wrap(JSON.generate(headers))
	end

	it 'can echo back headers' do
		response = client.get("/headers/response", {}, body({'content-type' => 'text/plain'}))
		
		expect(response.status).to be == 200
		expect(response.headers).to have_keys(
			'content-type' => be == 'text/plain'
		)
	ensure
		response&.finish
	end
end

with 'request headers' do
	it 'can echo back headers with multiple set-cookie values' do
		response = client.get("/headers/request", [['set-cookie', 'a=1'], ['set-cookie', 'b=2']])
		
		expect(response.status).to be == 200
		headers = JSON.parse(response.read)
		
		expect(headers).to have_keys(
			'HTTP_SET_COOKIE' => be == "a=1;b=2"
		)
	end
end
