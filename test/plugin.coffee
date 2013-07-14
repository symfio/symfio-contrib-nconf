suite = require "symfio-suite"
path = require "path"


describe "contrib-nconf()", ->
  it = suite.plugin (container) ->
    container.inject ["suite/container"], require ".."

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

  describe "container.unless configurationFile", ->
    it "should define", (unlessed) ->
      factory = unlessed "configurationFile"
      factory().should.eventually.equal "/config.json"

  it "should read configuration from process.env",
    ["injected", "suite/container"],
    (injected, container) ->
      factory = injected()
      factory.dependencies.container = container
      factory().then ->
        factory.dependencies.nconf.env.should.be.calledOnce
        container.set.should.be.calledWith "fromEnv", "env"

  it "should read configuration from process.argv",
    ["injected", "suite/container"],
    (injected, container) ->
      factory = injected()
      factory.dependencies.container = container
      factory().then ->
        factory.dependencies.nconf.argv.should.be.calledOnce
        container.set.should.be.calledWith "fromArgv", "argv"

  it "should read configuration from config.json",
    ["injected", "suite/container"],
    (injected, container) ->
      factory = injected()
      factory.dependencies.container = container
      factory().then ->
        factory.dependencies.nconf.file.should.be.calledOnce
        factory.dependencies.nconf.file.should.be.calledWith "/config.json"
        container.set.should.be.calledWith "fromFile", "file"
