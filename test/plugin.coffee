symfio = require "symfio"
plugin = require ".."
chai = require "chai"
path = require "path"


describe "contrib-nconf()", ->
  chai.use require "chai-as-promised"
  chai.should()

  it "should read configuration from process.env", (callback) ->
    process.env.symfio_fromEnv = "value"
    container = symfio "test", path.join __dirname, "support"

    container.inject(plugin).then ->
      container.get("fromEnv").should.eventually.equal "value"
    .should.notify callback
  
  it "should read configuration from process.argv", (callback) ->
    process.argv.push "--fromArgv"
    process.argv.push "value"
    container = symfio "test", path.join __dirname, "support"

    container.inject(plugin).then ->
      container.get("fromArgv").should.eventually.equal "value"
    .should.notify callback

  it "should read configuration from config.json", (callback) ->
    container = symfio "test", path.join __dirname, "support"

    container.inject(plugin).then ->
      container.get("fromFile").should.eventually.equal "value"
    .should.notify callback
