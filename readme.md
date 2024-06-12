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
  - Pitchfork (Rack 2 & 3)

## Usage

This repository includes test suite execution for published versions of major web servers. You can also run it for a specific server.

### Falcon

``` bash
export BUNDLE_GEMFILE=gems/falcon-v0-rack-v3.rb
bundle install
export RACK_CONFORM_SERVER="falcon --bind http://localhost:9292"
export RACK_CONFORM_ENDPOINT="http://localhost:9292"
bundle exec sus # run tests
```

To see more details about the tests being run, use `sus --verbose`.

Falcon can also run tests over `https` using a self-signed certificate and this will cause HTTP/2 to be used.

``` bash
export BUNDLE_GEMFILE=gems/falcon-v0-rack-v3.rb
bundle install
export RACK_CONFORM_SERVER="falcon --bind https://localhost:9292"
export RACK_CONFORM_ENDPOINT="https://localhost:9292"
bundle exec sus # run tests
```

### Puma

``` bash
export BUNDLE_GEMFILE=gems/puma-v6-rack-v3.rb
bundle install
export RACK_CONFORM_SERVER="puma --bind tcp://localhost:9292"
export RACK_CONFORM_ENDPOINT="http://localhost:9292"
bundle exec sus # run tests
```

### Webrick

``` bash
export BUNDLE_GEMFILE="gems/webrick-rack-v3.rb"
bundle install
export RACK_CONFORM_SERVER="rackup -s webrick"
export RACK_CONFORM_ENDPOINT="http://localhost:9292"
bundle exec sus
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
