suite = require "symfio-suite"
path = require "path"


describe "contrib-nconf()", ->
  it = suite.plugin [
    (container) ->
      container.set "applicationDirectory", path.join __dirname, "support"

    require ".."
  ]

  process.env.symfio_fromEnv = "env"
  process.argv.push "--fromArgv"
  process.argv.push "argv"

  after ->
    delete process.env.symfio_fromEnv
    process.argv.pop()
    process.argv.pop()

  it "should read configuration from process.env", (fromEnv) ->
    fromEnv.should.equal "env"

  it "should read configuration from process.argv", (fromArgv) ->
    fromArgv.should.equal "argv"

  it "should read configuration from config.json", (fromFile) ->
    fromFile.should.equal "file"
