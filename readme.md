# Rack::Conform

Provides rack server conformance testing.

[![Development Status](https://github.com/socketry/rack-conform/workflows/Test/badge.svg)](https://github.com/socketry/rack-conform/actions?workflow=Test)

## Motivation

Rack has pretty decent support for validating applications do the right thing using `Rack::Lint`. But nothing is really testing that servers behave correctly given a certain response from an application. That's what this test suite is for: to check that servers do the "correct" thing given a specific response from an application.

## Features

  - Supports Rack 2 and Rack 3.

### Servers Tested

  - Falcon (Rack 2 & 3)
  - Puma (Rack 2)
  - Passenger (Rack 2)
  - Unicorn (Rack 2)
  - Thin (Rack 2)

## Usage

This repository includes test suite execution for published versions of major web servers. You can also run it for a specific server:

``` bash
export BUNDLE_GEMFILE=gems/falcon-v0-rack-v3.rb
bundle install
export RACK_CONFORM_SERVER="falcon --bind http://localhost:9292"
export RACK_CONFORM_ENDPOINT="http://localhost:9292"
bundle exec sus # run tests
```

### Starting A Server

You can also start a server running the conform application for independent testing (e.g. using `curl`).

``` bash
export BUNDLE_GEMFILE=gems/falcon-v0-rack-v3.rb
bundle install
export RACK_CONFORM_SERVER="falcon --bind http://localhost:9292"
export RACK_CONFORM_ENDPOINT="http://localhost:9292"
bundle exec bake rack:conform:server
```
