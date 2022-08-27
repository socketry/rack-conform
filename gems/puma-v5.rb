# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022, by Samuel Williams.

eval_gemfile '../

gem "puma", "~> 5.0"

ENV['RACK_CONFORM_SERVER'] ||= "puma"
ENV['RACK_CONFORM_ENDPOINT'] ||= "http://localhost:9292"
