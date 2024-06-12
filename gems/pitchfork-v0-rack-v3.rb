# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../gems.rb'

gem "pitchfork", "~> 0.0"
gem "rack", "~> 3.0"

# export RACK_CONFORM_SERVER="pitchfork -E none"
# export RACK_CONFORM_ENDPOINT="http://localhost:8080"
