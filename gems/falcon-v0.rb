# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../'

gem "falcon", "~> 0.0"

ENV['RACK_CONFORM_SERVER'] ||= "falcon serve"
ENV['RACK_CONFORM_ENDPOINT'] ||= "https://localhost:9292"
