# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

eval_gemfile "../gems.rb"

gem "rack", "~> 3.2"
gem "webrick"
gem "rackup"

# export RACK_CONFORM_SERVER="rackup -s webrick"
# export RACK_CONFORM_ENDPOINT="http://127.0.0.1:9292"
