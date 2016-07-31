# This should cover a lot of varying use cases
# such as: CVE/advisory/summary identifiers
#          finding the deepest entries for each package@version
# Still need to have unit style testing, etc
module.exports = JSON.stringify [
  {
    "file": "\/home\/brent\/src\/brentlintner.ca\/bower_components\/" +
      "font-awesome\/src\/assets\/js\/jquery-1.10.2.js",
    "results": [
      # simulate a odd data dupe in retire json output
      {
        "version": "1.10.2",
        "component": "jquery",
        "detection": "filename",
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/jquery\/jquery\/issues\/2432",
              "http:\/\/blog.jquery.com\/2016\/01\/08\/jquery-2-2-and-1-12-released\/"
            ],
            "severity": "high",
            "identifiers": {
              "summary": "3rd party CORS request may execute"
            }
          }
        ]
      }
      {
        "version": "1.10.2",
        "component": "jquery",
        "detection": "filename",
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/jquery\/jquery\/issues\/2432",
              "http:\/\/blog.jquery.com\/2016\/01\/08\/jquery-2-2-and-1-12-released\/"
            ],
            "severity": "high",
            "identifiers": {
              "summary": "3rd party CORS request may execute"
            }
          }
        ]
      }
      {
        "version": "1.10.2",
        "component": "jquery",
        "detection": "filename",
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/jquery\/jquery\/issues\/2432",
              "http:\/\/blog.jquery.com\/2016\/01\/08\/jquery-2-2-and-1-12-released\/"
            ],
            "severity": "high",
            "identifiers": {
              "summary": "3rd party CORS request may execute"
            }
          }
        ]
      }
      {
        "version": "1.10.2",
        "component": "jquery",
        "detection": "filename",
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/jquery\/jquery\/issues\/2432",
              "http:\/\/blog.jquery.com\/2016\/01\/08\/jquery-2-2-and-1-12-released\/"
            ],
            "severity": "high",
            "identifiers": {
              "summary": "3rd party CORS request may execute"
            }
          }
        ]
      }
    ]
  }
  {
    "file": "\/home\/brent\/src\/brentlintner.ca\/bower_components" +
      "\/font-awesome\/src\/assets\/js\/jquery-1.10.2.min.js",
    "results": [
      {
        "version": "1.10.2.min",
        "component": "jquery",
        "detection": "filename",
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/jquery\/jquery\/issues\/2432",
              "http:\/\/blog.jquery.com\/2016\/01\/08\/jquery-2-2-and-1-12-released\/"
            ],
            "severity": "high",
            "identifiers": {
              "summary": "3rd party CORS request may execute"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "marked",
        "version": "0.3.5",
        "parent": {
          "component": "@forthright\/vile",
          "version": "0.9.11"
        },
        "level": 1,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/srcclr.com\/security\/cross-site-scripting-xss-due-to\/javascript\/s-2309"
            ],
            "severity": "medium",
            "identifiers": {
              "advisory": "Cross-Site Scripting (XSS) Due To Sanitization Bypass Using HTML Entities"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "marked",
        "version": "0.3.5",
        "parent": {
          "component": "dox",
          "version": "0.6.1",
          "parent": {
            "component": "repo-path-parse",
            "version": "1.0.1",
            "parent": {
              "component": "release-it",
              "version": "2.4.0",
              "parent": {
                "component": "@forthright\/vile",
                "version": "0.9.11"
              },
              "level": 1
            },
            "level": 2
          },
          "level": 3
        },
        "level": 4,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/srcclr.com\/security\/cross-site-scripting-xss-due-to\/javascript\/s-2309"
            ],
            "severity": "medium",
            "identifiers": {
              "advisory": "Cross-Site Scripting (XSS) Due To Sanitization Bypass Using HTML Entities"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "marked",
        "version": "0.3.5",
        "parent": {
          "component": "dox",
          "version": "0.6.1",
          "parent": {
            "component": "repo-path-parse",
            "version": "1.0.1",
            "parent": {
              "component": "doxme",
              "version": "1.8.2",
              "parent": {
                "component": "@forthright\/vile",
                "version": "0.9.11"
              },
              "level": 1
            },
            "level": 2
          },
          "level": 3
        },
        "level": 4,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/srcclr.com\/security\/cross-site-scripting-xss-due-to\/javascript\/s-2309"
            ],
            "severity": "medium",
            "identifiers": {
              "advisory": "Cross-Site Scripting (XSS) Due To Sanitization Bypass Using HTML Entities"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "marked",
        "version": "0.3.5",
        "parent": {
          "component": "dox",
          "version": "0.6.1",
          "parent": {
            "component": "@forthright\/vile",
            "version": "0.9.11"
          },
          "level": 1
        },
        "level": 2,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/srcclr.com\/security\/cross-site-scripting-xss-due-to\/javascript\/s-2309"
            ],
            "severity": "medium",
            "identifiers": {
              "advisory": "Cross-Site Scripting (XSS) Due To Sanitization Bypass Using HTML Entities"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "marked",
        "version": "0.3.5",
        "parent": {
          "component": "dox",
          "version": "0.6.1",
          "parent": {
            "component": "repo-path-parse",
            "version": "1.0.1",
            "parent": {
              "component": "@forthright\/vile",
              "version": "0.9.11"
            },
            "level": 1
          },
          "level": 2
        },
        "level": 3,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/srcclr.com\/security\/cross-site-scripting-xss-due-to\/javascript\/s-2309"
            ],
            "severity": "medium",
            "identifiers": {
              "advisory": "Cross-Site Scripting (XSS) Due To Sanitization Bypass Using HTML Entities"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "uglify-js",
        "version": "2.3.6",
        "parent": {
          "component": "handlebars",
          "version": "2.0.0",
          "parent": {
            "component": "bower",
            "version": "1.3.12",
            "parent": {
              "component": "constable",
              "version": "0.0.4",
              "parent": {
                "component": "@forthright\/vile-constable",
                "version": "0.1.10",
                "parent": {
                  "component": "brentlintner.ca",
                  "version": "0.0.11"
                },
                "level": 1
              },
              "level": 2
            },
            "level": 3
          },
          "level": 4,
          "vulnerabilities": [
            {
              "info": [
                "https:\/\/nodesecurity.io\/advisories\/61"
              ],
              "severity": "low",
              "identifiers": {
                "summary": "Quoteless Attributes in Templates can lead to Content Injection"
              }
            }
          ]
        },
        "level": 5,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/mishoo\/UglifyJS2\/issues\/751",
              "https:\/\/github.com\/tmcw\/mdast-uglify-bug"
            ]
          },
          {
            "info": [
              "https:\/\/nodesecurity.io\/advisories\/48"
            ]
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "uglify-js",
        "version": "2.2.5",
        "parent": {
          "component": "transformers",
          "version": "2.1.0",
          "parent": {
            "component": "jade",
            "version": "1.11.0",
            "parent": {
              "component": "brentlintner.ca",
              "version": "0.0.11"
            },
            "level": 1
          },
          "level": 2
        },
        "level": 3,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/github.com\/mishoo\/UglifyJS2\/issues\/751",
              "https:\/\/github.com\/tmcw\/mdast-uglify-bug"
            ]
          },
          {
            "info": [
              "https:\/\/nodesecurity.io\/advisories\/48"
            ]
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "handlebars",
        "version": "2.0.0",
        "parent": {
          "component": "bower",
          "version": "1.3.12",
          "parent": {
            "component": "constable",
            "version": "0.0.4",
            "parent": {
              "component": "brentlintner.ca",
              "version": "0.0.11"
            },
            "level": 1
          },
          "level": 2
        },
        "level": 3,
        "vulnerabilities": [
          {
            "info": [
              "https:\/\/nodesecurity.io\/advisories\/61"
            ],
            "severity": "low",
            "identifiers": {
              "CVE": "CVE-2014-6394",
              "summary": "Quoteless Attributes in Templates can lead to Content Injection"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "component": "foobar",
        "version": "2.0.0",
        "level": 1,
        "vulnerabilities": [
          {
            "info": [],
            "identifiers": {
              "summary": "Some summary"
            }
          }
        ]
      }
    ]
  }
  {
    "results": [
      {
        "vulnerabilities": [
          {
            "info": [],
            "identifiers": {
              "summary": "Some summary"
            }
          }
        ]
      }
    ]
  }
]
