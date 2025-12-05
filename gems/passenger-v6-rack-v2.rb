# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

eval_gemfile "../gems.rb"

gem "passenger", "~> 6.0"
gem "rack", "~> 2.0"

gem "base64"
gem "logger"

# export RACK_CONFORM_SERVER="passenger start"
# export RACK_CONFORM_ENDPOINT="http://127.0.0.1:3000"

::RACK_CONFORM_BROKEN = [:options_star]
