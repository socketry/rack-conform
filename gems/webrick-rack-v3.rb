# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../gems.rb'

# gem "rack", "~> 3.0"
gem "rack", git: "https://github.com/rack/rack", branch: "rack-lint-respond_to"
gem "webrick"
gem "rackup"

