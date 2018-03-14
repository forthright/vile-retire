"use strict";

var _ = require("lodash");
var fs = require("fs");
var ferret = require("@forthright/ferret");
var Bluebird = require("bluebird");

var RETIRE_BIN = "retire";
var RETIRE_REPORT = "retire-report.json";

Bluebird.promisifyAll(fs);

var to_json = function to_json(string) {
  return _.attempt(JSON.parse.bind(null, string));
};

var remove_report = function remove_report() {
  return fs.unlinkAsync(RETIRE_REPORT);
};

var read_report = function read_report() {
  return fs.readFileAsync(RETIRE_REPORT).then(function (data) {
    return remove_report().then(function () {
      return data ? to_json(data) : [];
    });
  });
};

var retire_check = function retire_check(plugin_config) {
  var cli_opts = _.get(plugin_config, "config", {});

  var cli_opts_as_args = _.flatMap(cli_opts, function (value, name) {
    var opt = ["--" + name];
    if (_.isArray(value)) value = value.join(",");
    if (_.isString(value)) opt.push(value);
    return opt;
  });

  var opts = {
    args: _.concat(cli_opts_as_args, ["--outputformat", "json", "--outputpath", RETIRE_REPORT])
  };

  return ferret.spawn(RETIRE_BIN, opts).then(read_report);
};

var result_name = function result_name(result) {
  return _.get(result, "component");
};

var result_version = function result_version(result) {
  return _.get(result, "version");
};

var sec_path = function sec_path(vulnerability, result) {
  return _.has(result, "file") ? _.get(result, "file") : "package.json";
};

var description = function description(vulnerability) {
  return _.get(vulnerability, "identifiers.advisory", _.get(vulnerability, "identifiers.summary", "has known security vulnerabilities"));
};

var cve = function cve(vulnerability) {
  return _.get(vulnerability, "identifiers.CVE");
};

var ferret_issue = function ferret_issue(vulnerability, result, file) {
  var severity = _.get(vulnerability, "severity");
  var desc = description(vulnerability);
  var name = result_name(result);
  var id = cve(vulnerability);
  var version = result_version(result);
  // TODO: ideally, we can pass all links
  var advisories = _.get(vulnerability, "info", []);
  var advisory = _.first(advisories);

  var msg = "";
  if (name) msg += "(" + name + "@" + version + ")";
  if (id) msg += " " + id;
  msg += " " + desc;
  if (severity) msg += " (severity: " + severity + ")";
  if (!_.isEmpty(advisories) && advisories.length > 1) {
    msg += " \n\n" + _.slice(advisories, 1).join("\n\n");
  }

  var sig_postfix = id || advisory || desc;
  var sig = "retire::" + name + "::" + version + "::" + sig_postfix;
  var sec_info = {
    package: name,
    version: version,
    advisory: advisory
  };

  return ferret.data({
    type: ferret.SEC,
    path: sec_path(vulnerability, result),
    message: _.trim(msg),
    signature: sig,
    security: sec_info
  });
};

// TODO: this needs some TLC/refactoring, etc
var into_issues = function into_issues(reports) {
  var issues = [];

  // HACK: to make manipulation a lot easier
  _.each(reports, function (report) {
    if (_.has(report, "file")) {
      _.each(_.get(report, "results"), function (result) {
        _.set(result, "file", _.get(report, "file"));
      });
    }
  });

  var results = _.flatMap(reports, "results");

  // [name][ver] = [ result, ... ]
  var map_by_name = _.reduce(results, function (map, result) {
    var name = _.get(result, "component", "?");
    var ver = _.get(result, "version", "?");

    if (!map[name]) map[name] = {};
    if (!map[name][ver]) map[name][ver] = [];
    map[name][ver].push(result);

    return map;
  }, {});

  _.each(map_by_name, function (versions, name) {
    _.each(versions, function (results, version) {
      _.each(results, function (result) {
        var file = _.get(result, "file");
        var vulnerabilities = _.get(result, "vulnerabilities", []);
        _.each(vulnerabilities, function (vulnerability) {
          issues.push(ferret_issue(vulnerability, result, file));
        });
      });
    });
  });

  // HACK: noticed odd dupe data with retire cli? this ensures no true dupes
  return _.uniqBy(issues, function (issue) {
    return issue.message + issue.signature;
  });
};

var exec = function exec(plugin_data) {
  return retire_check(plugin_data).then(into_issues);
};

module.exports = {
  context: ["node", "javascript"],
  exec: exec
};