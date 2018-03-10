const _ = require("lodash")
const fs = require("fs")
const vile = require("vile")
const Bluebird = require("bluebird")

const RETIRE_BIN = "retire"
const RETIRE_REPORT = "retire-report.json"

Bluebird.promisifyAll(fs)

let to_json = (string) =>
  _.attempt(JSON.parse.bind(null, string))

let remove_report = () =>
  fs.unlinkAsync(RETIRE_REPORT)

let read_report = () =>
  fs.readFileAsync(RETIRE_REPORT)
    .then((data) =>
      remove_report().then(() =>
        data ? to_json(data) : []))

let retire_check = (plugin_config) => {
  let cli_opts = _.get(plugin_config, "config", {})

  let cli_opts_as_args = _.flatMap(cli_opts, (value, name) => {
    let opt = [ `--${name}` ]
    if (_.isArray(value)) value = value.join(",")
    if (_.isString(value)) opt.push(value)
    return opt
  })

  let opts = {
    args: _.concat(
      cli_opts_as_args,
      [
        "--outputformat",
        "json",
        "--outputpath",
        RETIRE_REPORT
      ])
  }

  return vile
    .spawn(RETIRE_BIN, opts)
    .then(read_report)
}

let result_name = (result) =>
  _.get(result, "component")

let result_version = (result) =>
  _.get(result, "version")

let sec_path = (vulnerability, result) =>
  _.has(result, "file") ? _.get(result, "file") : "package.json"

let description = (vulnerability) =>
  _.get(vulnerability, "identifiers.advisory",
    _.get(vulnerability, "identifiers.summary",
      "has known security vulnerabilities"))

let cve = (vulnerability) =>
  _.get(vulnerability, "identifiers.CVE")

let vile_issue = (vulnerability, result, file) => {
  let severity = _.get(vulnerability, "severity")
  let desc = description(vulnerability)
  let name = result_name(result)
  let id = cve(vulnerability)
  let version = result_version(result)
  // TODO: ideally, we can pass all links
  let advisories = _.get(vulnerability, "info", [])
  let advisory = _.first(advisories)

  let msg = ""
  if (name) msg += `(${name}@${version})`
  if (id) msg += ` ${id}`
  msg += ` ${desc}`
  if (severity) msg += ` (severity: ${severity})`
  if (!_.isEmpty(advisories) && advisories.length > 1) {
    msg += ` \n\n${_.slice(advisories, 1).join("\n\n")}`
  }

  let sig_postfix = id || advisory || desc
  let sig = `retire::${name}::${version}::${sig_postfix}`
  let sec_info = {
    package: name,
    version: version,
    advisory: advisory
  }

  return vile.issue({
    type: vile.SEC,
    path: sec_path(vulnerability, result),
    message: _.trim(msg),
    signature: sig,
    security: sec_info
  })
}

// TODO: this needs some TLC/refactoring, etc
let into_issues = (reports) => {
  let issues = []

  // HACK: to make manipulation a lot easier
  _.each(reports, (report) => {
    if (_.has(report, "file")) {
      _.each(_.get(report, "results"), (result) => {
        _.set(result, "file", _.get(report, "file"))
      })
    }
  })

  let results = _.flatMap(reports, "results")

  // [name][ver] = [ result, ... ]
  let map_by_name = _.reduce(results, (map, result) => {
    let name = _.get(result, "component", "?")
    let ver = _.get(result, "version", "?")

    if (!map[name]) map[name] = {}
    if (!map[name][ver]) map[name][ver] = []
    map[name][ver].push(result)

    return map
  }, {})

  _.each(map_by_name, (versions, name) => {
    _.each(versions, (results, version) => {
      _.each(results, (result) => {
        let file = _.get(result, "file")
        let vulnerabilities = _.get(result, "vulnerabilities", [])
        _.each(vulnerabilities, (vulnerability) => {
          issues.push(vile_issue(vulnerability, result, file))
        })
      })
    })
  })

  // HACK: noticed odd dupe data with retire cli? this ensures no true dupes
  return _.uniqBy(issues, (issue) => issue.message + issue.signature)
}

let punish = (plugin_data) =>
  retire_check(plugin_data)
    .then(into_issues)

module.exports = {
  punish: punish
}
