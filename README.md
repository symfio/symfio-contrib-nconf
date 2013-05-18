# symfio-contrib-nconf

> Read configuration from config.json and save it into container.

## Usage

```coffee
symfio = require "symfio"

container = symfio "example", __dirname

loader = container.get "loader"

loader.use require "symfio-contrib-nconf"

loader.use (container, callback) ->
  console.log container.get "some setting from config.json"
  callback()

loader.load()
```

## Required plugins

* [contrib-express](https://github.com/symfio/symfio-contrib-express)
