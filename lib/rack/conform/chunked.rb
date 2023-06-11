
module Rack
	module Conform
		module Chunked
			class Body # :nodoc:
				TERM = "\r\n"
				TAIL = "0#{TERM}"

				# Store the response body to be chunked.
				def initialize(body)
					@body = body
				end

				# For each element yielded by the response body, yield
				# the element in chunked encoding.
				def each(&block)
					term = TERM
					@body.each do |chunk|
						size = chunk.bytesize
						next if size == 0

						yield [size.to_s(16), term, chunk.b, term].join
					end
					yield TAIL
					yield term
				end

				# Close the response body if the response body supports it.
				def close
					@body.close if @body.respond_to?(:close)
				end
			end
		end
		
		class Application
			def test_chunked_body(env)
				[200, {'transfer-encoding' => 'chunked'}, Chunked::Body.new(env['rack.input'])]
			end
		end
	end
end
