# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../gems.rb'

gem "pitchfork", git: "https://github.com/Shopify/pitchfork.git"
gem "rack", "~> 2.0"

# export RACK_CONFORM_SERVER="pitchfork -E none"
# export RACK_CONFORM_ENDPOINT="http://localhost:8080"
