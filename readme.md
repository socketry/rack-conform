# Rack::Conform

Provides rack server conformance testing.

[![Development Status](https://github.com/socketry/protocol-http/workflows/Test/badge.svg)](https://github.com/socketry/protocol-http/actions?workflow=Test)

## Features

  - Supports Rack 2 and Rack 3.

## Usage

This repository includes test suite execution for published versions of major web servers. You can also run it for a specific server:

```bash
$ puma & # start your server
$ export RACK_CONFORM_ENDPOINT="http://localhost:9292"
$ bundle exec sus # run tests
```
