# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

def body(headers)
	Protocol::HTTP::Body::Buffered.wrap(JSON.generate(headers))
end

it 'can respond with a single cookie' do
	response = client.get("/cookies", [['cookie', 'a=1']])
	
	expect(response.status).to be == 200
	expect(response.headers).to have_keys(
		'set-cookie' => be == ['a=1']
	)
ensure
	response&.finish
end

it 'can respond with multiple combined cookies' do
	response = client.get("/cookies", [['cookie', 'a=1;b=2']])
	
	expect(response.status).to be == 200
	expect(response.headers).to have_keys(
		'set-cookie' => be == ["a=1", "b=2"]
	)
ensure
	response&.finish
end

it 'can respond with multiple cookie headers' do
	response = client.get("/cookies", [['cookie', 'a=1'], ['cookie', 'b=2']])
	
	expect(response.status).to be == 200
	expect(response.headers).to have_keys(
		'set-cookie' => be == ['a=1', 'b=2']
	)
ensure
	response&.finish
end
