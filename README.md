# symfio-contrib-nconf

> Read configuration from config.json and save it into container.

[![Build Status](https://travis-ci.org/symfio/symfio-contrib-nconf.png?branch=master)](https://travis-ci.org/symfio/symfio-contrib-nconf)
[![Coverage Status](https://coveralls.io/repos/symfio/symfio-contrib-nconf/badge.png?branch=master)](https://coveralls.io/r/symfio/symfio-contrib-nconf?branch=master)
[![Dependency Status](https://gemnasium.com/symfio/symfio-contrib-nconf.png)](https://gemnasium.com/symfio/symfio-contrib-nconf)
[![NPM version](https://badge.fury.io/js/symfio-contrib-nconf.png)](http://badge.fury.io/js/symfio-contrib-nconf)

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
