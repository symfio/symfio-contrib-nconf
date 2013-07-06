module.exports = (container) ->
  container.unless "configurationFile", (applicationDirectory) ->
    path = require "path"
    path.join applicationDirectory, "config.json"

  container.set "nconf", (logger) ->
    logger.debug "require module", name: "nconf"
    require "nconf"

  container.inject (nconf, configurationFile, logger) ->
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
