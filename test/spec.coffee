fs = require "fs"
mimus = require "mimus"
Promise = require "bluebird"
retire = mimus.require "./../lib", __dirname, []
chai = require "./helpers/sinon_chai"
util = require "./helpers/util"
vile = mimus.get retire, "vile"
expect = chai.expect

Promise.promisifyAll fs

# TODO: write integration tests for spawn -> cli
# TODO: don't use setTimeout everywhere (for proper exception throwing)

RETIRE_REPORT = "retire-report.json"

describe "retire", ->
  afterEach mimus.reset
  after -> mimus.restore()

  beforeEach ->
    mimus.stub vile, "spawn"
    util.setup vile

  describe "#punish", ->
    it "converts a retire json response to issues", ->
      retire
        .punish {}
        .should.eventually.eql util.issues

    it "handles an empty response", ->
      fs.readFileAsync.reset()
      fs.readFileAsync.returns new Promise (resolve) -> resolve ""

      retire
        .punish {}
        .should.eventually.eql []

    it "sets the retire cli's output format to json", (done) ->
      retire
        .punish {}
        .should.be.fulfilled.notify ->
          setTimeout ->
            vile.spawn.should.have.been
              .calledWith "retire", args: [
                              "--outputformat"
                              "json"
                              "--outputpath"
                              RETIRE_REPORT
                            ]
            done()
      return

    it "reads the report file", (done) ->
      retire
        .punish {}
        .should.be.fulfilled.notify ->
          setTimeout ->
            fs.readFileAsync.should.have.been
              .calledWith RETIRE_REPORT
            done()
      return

    it "removes the report file", (done) ->
      retire
        .punish {}
        .should.be.fulfilled.notify ->
          setTimeout ->
            fs.unlinkAsync.should.have.been
              .calledWith RETIRE_REPORT
            done()
      return

    describe "config", ->
      it "converts a boolean long form option", (done) ->
        retire
          .punish { config: package: true, node: true }
          .should.be.fulfilled.notify ->
            setTimeout ->
              vile.spawn.should.have.been
                .calledWith "retire", args: [
                                "--package"
                                "--node"
                                "--outputformat"
                                "json"
                                "--outputpath"
                                RETIRE_REPORT
                              ]
              done()
        return

      it "converts a string long form option", (done) ->
        retire
          .punish { config: proxy: "http://some.where", path: "." }
          .should.be.fulfilled.notify ->
            setTimeout ->
              vile.spawn.should.have.been
                .calledWith "retire", args: [
                                "--proxy"
                                "http://some.where"
                                "--path"
                                "."
                                "--outputformat"
                                "json"
                                "--outputpath"
                                RETIRE_REPORT
                              ]
              done()
        return

      describe "when converting an ignore property", ->
        it "joins the value as string", (done) ->
          retire
            .punish config: ignore: ["foo", "bar"]
            .should.be.fulfilled.notify ->
              setTimeout ->
                vile.spawn.should.have.been
                  .calledWith "retire", args: [
                                "--ignore"
                                "foo,bar"
                                "--outputformat"
                                "json"
                                "--outputpath"
                                RETIRE_REPORT
                              ]
                done()
          return
