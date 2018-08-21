#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  class Entry

    class << self

      def default_folder
        @default_folder || File.join('.', 'config')
      end

      def default_folder=(path)
        @default_folder = path
      end

      def default_file(name)
        File.join(default_folder, "#{name}.yml.erb")
      end

    end

    attr_reader :key

    attr_accessor :filenames

    def initialize(key, filenames: nil)
      raise ArgumentError, 'key is required' unless key && key.to_s.length > 0

      @key        = key.to_s
      @filenames  = filenames
    end

    def filenames=(filenames)
      protected!

      @filenames = filenames
    end

    def loaded?
      @loaded || false
    end

    def all
      load!

      @configuration&.all || {}
    end

    def loaded_filenames
      @configuration&.loaded_filenames || []
    end

    private

    def protected!
      raise ArgumentError, "[Illegal] #{key} config store has been re-configured after it was loaded." if loaded?
    end

    def loaded!
      @loaded = true
    end

    def load!
      if loaded?
        @configuration.load!
        return
      end

      names = Array(filenames).flatten

      names = [ self.class.default_file(key) ] if names.length == 0

      @configuration = FileBasedConfiguration.new(names)

      loaded!
    end

  end
end
