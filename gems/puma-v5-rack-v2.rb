# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile "../gems.rb"

gem "puma", "~> 5.0"
gem "rack", "~> 2.0"

# export RACK_CONFORM_SERVER="puma"
# export RACK_CONFORM_ENDPOINT="http://localhost:9292"
