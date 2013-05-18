symfio = require "symfio"
plugin = require "../lib/nconf"
suite = require "symfio-suite"
path = require "path"


describe "contrib-nconf plugin", ->
  wrapper = suite.sandbox symfio, ->
    @container.set "application directory", path.join __dirname, "support"

  it "should read configuration from config.json", wrapper ->
    plugin @container, ->
    @expect(@container.get "key").to.equal "value"
