# Rack::Conform

Provides rack server conformance testing.

[![Development Status](https://github.com/socketry/protocol-http/workflows/Test/badge.svg)](https://github.com/socketry/protocol-http/actions?workflow=Test)

## Motivation

Rack has pretty decent support for validating applications do the right thing using `Rack::Lint`. But nothing is really testing that servers behave correctly given a certain response from an application. That's what this test suite is for: to check that servers do the "correct" thing given a specific response from an application.

## Features

  - Supports Rack 2 and Rack 3.

## Usage

This repository includes test suite execution for published versions of major web servers. You can also run it for a specific server:

```bash
$ puma & # start your server
$ export RACK_CONFORM_ENDPOINT="http://localhost:9292"
$ bundle exec sus # run tests
```
