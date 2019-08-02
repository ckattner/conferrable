# Conferrable

[![Gem Version](https://badge.fury.io/rb/conferrable.svg)](https://badge.fury.io/rb/conferrable) [![Build Status](https://travis-ci.org/bluemarblepayroll/conferrable.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/conferrable) [![Maintainability](https://api.codeclimate.com/v1/badges/4149dfc2579b9345c4be/maintainability)](https://codeclimate.com/github/bluemarblepayroll/conferrable/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/4149dfc2579b9345c4be/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/conferrable/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

We have seen our applications gain more and more static configuration files over time.  A common library we use on a daily basis is these configuration file loaders.  Conferrable standardizes how we interact with these static YAML configuration files.  It offers a simple and extendable API for dealing with the following scenarios:

* Load a YAML file
* Load a directory of YAML files
* Load multiple YAML files

## Installation

To install through Rubygems:

````
gem install install conferrable
````

You can also add this to your Gemfile:

````
bundle add conferrable
````

## Examples

### Simple Example

Lets say we have a configuration file located at:

````
<app root>/config/config.yml
````

We can access this by:

````
config = Conferrable.get_config # config will be a hash
````

### Multiple File Example

Building on the simple example, say we have two configuration files:

````
<app root>/config/config1.yml
<app root>/config/config2.yml
````

We can now explicitly set the files:

````
files = [
  './config/config1.yml',
  './config/config2.yml',
]

Conferrable.set_filenames(:config, files)

config = Conferrable.get_config # config will be a hash
````

Alternatively, we could use a directory:

````
Conferrable.set_filenames(:config, './config')

config = Conferrable.get_config # config will be a hash
````

Note that the files will be loaded in alphabetical order.

### ERB Support ###

If a configuration file ends in '.erb', then it will be pre-processed by the ERB templating system. For example, a file named config.yml.erb would first be processed by ERB and then parsed as a YAML file. This is helpful when dealing with more complex YAML files.

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check conferrable.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/conferrable.git)
4. Navigate to the root folder (cd conferrable)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/conferrable/version.rb``` using [semantic versioning](https://semver.org/)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Build the project locally: `gem build conferrable`
7. Publish package to RubyGems: `gem push conferrable-X.gem` where X is the version to push
8. Tag master with new version: `git tag <version>`
9. Push tags remotely: `git push origin --tags`

## License

This project is MIT Licensed.
