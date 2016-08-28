fs = require "fs"
mimus = require "mimus"
Bluebird = require "bluebird"
retire_json = require "./../fixtures/retire-json"

setup = (vile) ->
  mimus.stub(fs, "readFileAsync").returns(
    new Bluebird((resolve, reject) -> resolve(retire_json)))

  mimus.stub(fs, "unlinkAsync").returns(
    new Bluebird((resolve, reject) -> resolve()))

  vile.spawn.returns new Bluebird (resolve) -> resolve()

# file types, node types. with/without various identifiers and info links
issues = [
  {
    path: "/home/brent/src/brentlintner.ca/bower_components/" +
      "font-awesome/src/assets/js/jquery-1.10.2.js"
    message: "(jquery@1.10.2) 3rd party CORS request " +
      "may execute (severity: high)" +
      " - https://github.com/jquery/jquery/issues/2432 - " +
      "http://blog.jquery.com/2016/01/08/jquery-2-2-and-1-12-released/",
    type: "security",
    signature: "retire::jquery::" +
      "1.10.2::https://github.com/jquery/jquery/issues/2432",
    security: {
      package: "jquery",
      version: "1.10.2",
      advisory: "https://github.com/jquery/jquery/issues/2432",
    }
  }
  {
    path: "/home/brent/src/brentlintner.ca/bower_components/" +
      "font-awesome/src/assets/js/jquery-1.10.2.min.js"
    message: "(jquery@1.10.2.min) 3rd party CORS " +
      "request may execute (severity: high)" +
      " - https://github.com/jquery/jquery/issues/2432 - " +
      "http://blog.jquery.com/2016/01/08/jquery-2-2-and-1-12-released/",
    type: "security",
    signature: "retire::jquery::" +
      "1.10.2.min::https://github.com/jquery/jquery/issues/2432",
    security: {
      package: "jquery",
      version: "1.10.2.min",
      advisory: "https://github.com/jquery/jquery/issues/2432",
    }
  }
  {
    path: "package.json",
    message: "(marked@0.3.5) Cross-Site Scripting (XSS) Due" +
      " To Sanitization Bypass Using HTML Entities (severity: medium) " +
      "(@forthright/vile@0.9.11 > release-it@2.4.0 > " +
      "repo-path-parse@1.0.1 > dox@0.6.1)" +
      " - " +
      "https://srcclr.com/security/" +
      "cross-site-scripting-xss-due-to/javascript/s-2309",
    type: "security",
    signature: "retire::marked::0.3.5::" +
      "https://srcclr.com/security/" +
      "cross-site-scripting-xss-due-to/javascript/s-2309"
    security: {
      package: "marked",
      version: "0.3.5",
      advisory: "https://srcclr.com/security/" +
        "cross-site-scripting-xss-due-to/javascript/s-2309"
    }
  }
  {
    path: "package.json",
    message: "(marked@0.3.5) Cross-Site Scripting (XSS) Due" +
      " To Sanitization Bypass Using HTML Entities (severity: medium) " +
      "(@forthright/vile@0.9.11 > doxme@1.8.2 > repo-path-parse@1.0.1 " +
      "> dox@0.6.1)" +
      " - " +
      "https://srcclr.com/security/" +
      "cross-site-scripting-xss-due-to/javascript/s-2309",
    type: "security",
    signature: "retire::marked::0.3.5::" +
      "https://srcclr.com/security/" +
      "cross-site-scripting-xss-due-to/javascript/s-2309",
    security: {
      package: "marked",
      version: "0.3.5",
      advisory: "https://srcclr.com/security/" +
        "cross-site-scripting-xss-due-to/javascript/s-2309"
    }
  }
  {
    path: "package.json",
    message: "(uglify-js@2.3.6) has known security vulnerabilities " +
      "(brentlintner.ca@0.0.11 > @forthright/vile-constable@0.1.10 > " +
      "constable@0.0.4 > bower@1.3.12 > handlebars@2.0.0)" +
      " - https://github.com/mishoo/UglifyJS2/issues/751 - " +
      "https://github.com/tmcw/mdast-uglify-bug",
    type: "security",
    signature: "retire::uglify-js::2.3.6::https://" +
      "github.com/mishoo/UglifyJS2/issues/751",
    security: {
      package: "uglify-js",
      version: "2.3.6",
      advisory: "https://github.com/mishoo/UglifyJS2/issues/751"
    }
  }
  {
    path: "package.json",
    message: "(uglify-js@2.3.6) has known security vulnerabilities " +
      "(brentlintner.ca@0.0.11 > @forthright/vile-constable@0.1.10 > " +
      "constable@0.0.4 > bower@1.3.12 > handlebars@2.0.0)" +
      " - https://nodesecurity.io/advisories/48",
    type: "security",
    signature: "retire::uglify-js::2.3.6::" +
      "https://nodesecurity.io/advisories/48",
    security: {
      package: "uglify-js",
      version: "2.3.6",
      advisory: "https://nodesecurity.io/advisories/48"
    }
  }
  {
    path: "package.json",
    message: "(uglify-js@2.2.5) has known security vulnerabilities " +
      "(brentlintner.ca@0.0.11 > jade@1.11.0 > transformers@2.1.0)" +
      " - https://github.com/mishoo/UglifyJS2/issues/751 - " +
      "https://github.com/tmcw/mdast-uglify-bug",
    type: "security",
    signature: "retire::uglify-js::2.2.5::" +
      "https://github.com/mishoo/UglifyJS2/issues/751",
    security: {
      package: "uglify-js",
      version: "2.2.5",
      advisory: "https://github.com/mishoo/UglifyJS2/issues/751"
    }
  }
  {
    path: "package.json",
    message: "(uglify-js@2.2.5) has known security vulnerabilities " +
      "(brentlintner.ca@0.0.11 > jade@1.11.0 > transformers@2.1.0)" +
      " - https://nodesecurity.io/advisories/48"
    type: "security",
    signature: "retire::uglify-js::2.2.5::" +
      "https://nodesecurity.io/advisories/48",
    security: {
      package: "uglify-js",
      version: "2.2.5"
      advisory: "https://nodesecurity.io/advisories/48"
    }
  }
  {
    path: "package.json",
    message: "(handlebars@2.0.0) " +
      "CVE-2014-6394 Quoteless Attributes in " +
      "Templates can lead to Content Injection " +
      "(severity: low) " +
      "(brentlintner.ca@0.0.11 > constable@0.0.4 > bower@1.3.12)" +
      " - https://nodesecurity.io/advisories/61"
    type: "security",
    signature: "retire::handlebars::2.0.0::CVE-2014-6394",
    security: {
      package: "handlebars",
      version: "2.0.0"
      advisory: "https://nodesecurity.io/advisories/61"
    }
  }
  {
    path: "package.json",
    message: "(foobar@2.0.0) Some summary"
    type: "security",
    signature: "retire::foobar::2.0.0::Some summary",
    security: {
      package: "foobar",
      version: "2.0.0",
      advisory: undefined
    }
  }
  {
    path: "package.json",
    message: "Some summary"
    type: "security",
    signature: "retire::undefined::undefined::Some summary",
    security: {
      package: undefined,
      version: undefined,
      advisory: undefined
    }
  }
]

module.exports =
  issues: issues
  setup: setup
