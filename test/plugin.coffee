suite = require "symfio-suite"


describe "contrib-nconf()", ->
  it = suite.plugin (container) ->
    container.inject ["suite/container"], require ".."

    container.require "path"
    container.set "applicationDirectory", "/"
    container.set "configurationFile", "/config.json"

    container.set "nconf", (sandbox) ->
      nconf =
        env: sandbox.spy()
        argv: sandbox.spy()
        file: sandbox.spy()

      nconf.stores =
        env: store: symfio_fromEnv: "env"
        argv: store: fromArgv: "argv"
        file: store: fromFile: "file"

      nconf

  describe "container.require path", ->
    it "should require path", (required) ->
      required("path").should.equal "path"

  describe "container.require nconf", ->
    it "should require nconf", (required) ->
      required("nconf").should.equal "nconf"

  describe "container.unless configurationFile", ->
    it "should define", (unlessed) ->
      factory = unlessed "configurationFile"
      factory().should.eventually.equal "/config.json"

  describe "container.set loadConfig", ->
    it "should read configuration from process.env",
      ["setted", "suite/container"],
      (setted, container) ->
        factory = setted "loadConfig"
        factory.dependencies.container = container
        factory().then (loadConfig) ->
          loadConfig()
          factory.dependencies.nconf.env.should.be.calledOnce
          container.set.should.be.calledWith "fromEnv", "env"

    it "should read configuration from process.argv",
      ["setted", "suite/container"],
      (setted, container) ->
        factory = setted "loadConfig"
        factory.dependencies.container = container
        factory().then (loadConfig) ->
          loadConfig()
          factory.dependencies.nconf.argv.should.be.calledOnce
          container.set.should.be.calledWith "fromArgv", "argv"

    it "should read configuration from config.json",
      ["setted", "suite/container"],
      (setted, container) ->
        factory = setted "loadConfig"
        factory.dependencies.container = container
        factory().then (loadConfig) ->
          loadConfig()
          factory.dependencies.nconf.file.should.be.calledOnce
          factory.dependencies.nconf.file.should.be.calledWith "/config.json"
          container.set.should.be.calledWith "fromFile", "file"
