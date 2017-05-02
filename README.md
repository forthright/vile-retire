# vile-retire [![circle ci build status](https://circleci.com/gh/forthright/vile-retire.svg?style=shield&circle-token=6be2dc62849170210b40aba8e999f825b0b99335)](https://circleci.com/gh/forthright/vile-retire) [![appveyor build status](https://ci.appveyor.com/api/projects/status/auqlywbel1fb2trx/branch/master?svg=true)](https://ci.appveyor.com/project/brentlintner/vile-retire/branch/master) [![score-badge](https://vile.io/api/v0/projects/vile-retire/badges/score?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-retire) [![security-badge](https://vile.io/api/v0/projects/vile-retire/badges/security?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-retire) [![coverage-badge](https://vile.io/api/v0/projects/vile-retire/badges/coverage?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-retire) [![dependency-badge](https://vile.io/api/v0/projects/vile-retire/badges/dependency?token=USryyHar5xQs7cBjNUdZ)](https://vile.io/~brentlintner/vile-retire)

A [vile](https://vile.io) plugin for [RetireJS](https://github.com/RetireJS/retire.js).

## Requirements

- [nodejs](http://nodejs.org)
- [npm](http://npmjs.org)

## Installation

    npm i -D vile retire vile-retire

## Config

The config is one to one with (most of) retire's `--` style CLI options.

Example:

```yaml
retire:
  config:
    package: true
    node: true
    js: true
    dropexternal: true
    nocache: true
    jspath: "sompath"
    nodepath: "somepath"
    path: "somepath"
    jsrepo: "..."
    noderepo: "..."
    proxy: "http://..."
    ignorefile: "somepath/.retireignore"
```

## Ignoring Files

Since RetireJS actually might want to scan some directories you would
otherwise ignore, such as `node_modules`, you can only configure that
as part of the config section:

```yaml
retire:
  config:
    ignore:
      - one
      - two
```

This list will be mapped to the `--ignore` option.

You can also use `.retireignore` as the `retire` CLI will pick it up.

## Allowing Files

With what this plugin offers, the `allow` list is not really needed.

Try the `--path|nodepath|jspath` config options, if need be.

## Versioning

This project ascribes to [semantic versioning](http://semver.org).

## Licensing

This project is licensed under the [MPL-2.0](LICENSE) license.

Any contributions made to this project are made under the current license.

## Contributions

Current list of [Contributors](https://github.com/forthright/vile-retire/graphs/contributors).

Any contributions are welcome and appreciated!

All you need to do is submit a [Pull Request](https://github.com/forthright/vile-retire/pulls).

1. Please consider tests and code quality before submitting.
2. Please try to keep commits clean, atomic and well explained (for others).

### Issues

Current issue tracker is on [GitHub](https://github.com/forthright/vile-retire/issues).

Even if you are uncomfortable with code, an issue or question is welcome.

### Code Of Conduct

This project ascribes to [contributor-covenant.org](http://contributor-covenant.org).

By participating in this project you agree to our [Code of Conduct](CODE_OF_CONDUCT.md).

### Maintainers

- Brent Lintner - [@brentlintner](http://github.com/brentlintner)

## Architecture

This project is currently written in JavaScript. RetireJS provides
a JSON CLI output that is currently used until a more ideal
IPC option is implemented.

- `bin` houses any shell based scripts
- `src` is es6+ syntax compiled with [babel](https://babeljs.io)
- `lib` generated js library

## Hacking

    cd vile-retire
    npm install
    npm install retire
    npm run dev
    npm test
