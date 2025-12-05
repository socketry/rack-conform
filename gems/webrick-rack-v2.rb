# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile "../gems.rb"

gem "rack", "~> 2.0"
gem "webrick"

::RACK_CONFORM_BROKEN = [:options_star]
