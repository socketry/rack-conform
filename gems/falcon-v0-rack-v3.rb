# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../gems.rb'

gem "falcon", "~> 0.0"
gem "rack", "~> 3.0.0.rc1"

# export RACK_CONFORM_SERVER="falcon serve"
# export RACK_CONFORM_ENDPOINT="https://localhost:9292"

# export RACK_CONFORM_SERVER="falcon serve --bind http://localhost:9292"
# export RACK_CONFORM_ENDPOINT="http://localhost:9292"
