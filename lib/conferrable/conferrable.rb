#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'yaml'
require 'erb'

require_relative 'file_utilities'
require_relative 'configuration'
require_relative 'file_based_configuration'
require_relative 'entry'

module Conferrable

  GET_PREFIX_MATCHER_REGEX  = /^get_(.+)$/
  GET_PREFIX_REGEX          = /^get_/

  class << self

    def clear!
      @entries = {}

      nil
    end

    def set_filenames(key, filenames)
      entry(key).filenames = filenames
    end

    def [](key)
      get(key)
    end

    def get(key)
      entry(key).all
    end

    def entry(key)
      clear! unless @entries

      @entries[key.to_s] = Entry.new(key) unless @entries[key.to_s]

      @entries[key.to_s]
    end

    def method_missing(method_sym, *arguments, &block)
      if method_sym.to_s =~ GET_PREFIX_MATCHER_REGEX
        get(keyify(method_sym))
      else
        super
      end
    end

    def respond_to_missing?(method_sym, include_private = false)
      method_sym.to_s =~ GET_PREFIX_MATCHER_REGEX || super
    end

    private

    def keyify(val)
      val.to_s.sub(GET_PREFIX_REGEX, '')
    end

  end
end
