module.exports = (container) ->
  container.require require
  container.require "path"
  container.require "nconf"

  container.unless "configurationFile", (applicationDirectory, path) ->
    path.join applicationDirectory, "config.json"

  container.set "loadConfig", (container, nconf, configurationFile, logger) ->
    ->
      nconf.env()
      nconf.argv()
      nconf.file configurationFile

      for key, value of nconf.stores.env.store
        if /^symfio_[a-z][a-zA-Z]*$/.test key
          key = key.replace /^symfio_/, ""
          logger.debug "container value", store: "env", key: key
          container.set key, value

      for key, value of nconf.stores.argv.store
        unless key in ["_", "$0"]
          logger.debug "container value", store: "argv", key: key
          container.set key, value

      for key, value of nconf.stores.file.store
        logger.debug "container value", store: "file", key: key
        container.set key, value
