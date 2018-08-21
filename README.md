# Conferrable

[![Build Status](https://travis-ci.org/bluemarblepayroll/conferrable.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/conferrable)

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
<app root>/config/config.yml.erb
````

We can access this by:

````
config = Conferrable.get_config # config will be a hash
````

### Multiple File Example

Building on the simple example, say we have two configuration files:

````
<app root>/config/config1.yml.erb
<app root>/config/config2.yml.erb
````

We can now explicitly set the files:

````
files = [
  './config/config1.yml.erb',
  './config/config2.yml.erb',
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
rspec
````

## License

This project is MIT Licensed.
