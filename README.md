# symfio-contrib-nconf

> Read configuration from config.json and save it into container.

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
