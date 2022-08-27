# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

def body(headers)
	Protocol::HTTP::Body::Buffered.wrap(JSON.generate(headers))
end

it 'can echo back headers' do
	response = client.get("/headers", {}, body({'content-type' => 'text/plain'}))
	
	expect(response.status).to be == 200
	expect(response.headers).to have_keys(
		'content-type' => be == 'text/plain'
	)
ensure
	response&.finish
end
