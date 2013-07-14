# symfio-contrib-nconf

> Read configuration from config.json and save it into container.

[![Build Status](https://travis-ci.org/symfio/symfio-contrib-nconf.png?branch=master)](https://travis-ci.org/symfio/symfio-contrib-nconf) [![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-nconf.png)](https://gemnasium.com/symfio/symfio-contrib-nconf)

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

container.inject require "symfio-contrib-nconf"
```

## Configuration

### `configurationFile`

Default value is `config.json`.

## Services

### `nconf`

Original `nconf` module.

### `loadConfig`

Function used to load config before all plugins.
