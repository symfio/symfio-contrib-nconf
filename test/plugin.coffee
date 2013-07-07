suite = require "symfio-suite"
path = require "path"


describe "contrib-nconf()", ->
  it = suite.plugin (container, containerStub) ->
    require("..") containerStub

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
    it "should define", (containerStub) ->
      factory = containerStub.unless.get "configurationFile"
      factory("/").should.equal "/config.json"

  it "should read configuration from process.env",
    (containerStub, nconf, logger) ->
      factory = containerStub.inject.get 0
      factory containerStub, nconf, "config.json", logger
      nconf.env.should.be.calledOnce
      containerStub.set.should.be.calledWith "fromEnv", "env"

  it "should read configuration from process.argv",
    (containerStub, nconf, logger) ->
      factory = containerStub.inject.get 0
      factory containerStub, nconf, "config.json", logger
      nconf.argv.should.be.calledOnce
      containerStub.set.should.be.calledWith "fromArgv", "argv"

  it "should read configuration from config.json",
    (containerStub, nconf, logger) ->
      factory = containerStub.inject.get 0
      factory containerStub, nconf, "config.json", logger
      nconf.file.should.be.calledOnce
      nconf.file.should.be.calledWith "config.json"
      containerStub.set.should.be.calledWith "fromFile", "file"
