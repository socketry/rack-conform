# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

require 'client_context'
include ClientContext

require 'rack'

it 'can stream an enumerator repsonse body' do
	response = client.get("/streaming/enumerator")
	
	expect(response.status).to be == 200
	
	chunks = []
	
	response.body.each do |chunk|
		chunks << chunk
	end
	
	expected_chunks = 10.times.map do |i|
		"Hello World #{i}\n"
	end
	
	expect(chunks.join).to be == expected_chunks.join
	if chunks.size > 1
		inform("Received #{chunks.size} chunks: streaming supported.")
	end
ensure
	response&.finish
end
