# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../gems.rb'

gem "unicorn", "~> 6.0"
gem "rack", "~> 2.0"

# export RACK_CONFORM_SERVER="unicorn"
# export RACK_CONFORM_ENDPOINT="http://localhost:8080"
