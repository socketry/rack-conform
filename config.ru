# frozen_string_literal: true

require_relative "lib/rack/conform/application"
run Rack::Conform::Application.new
