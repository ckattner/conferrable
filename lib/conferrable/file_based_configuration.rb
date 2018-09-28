# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  # This class extends the Configuration class by introducing the concept of
  # loading from a file.
  class FileBasedConfiguration < Configuration
    attr_reader :filenames, :loaded_filenames

    def initialize(*filenames)
      super() # explicit () because we do not want to send in filenames

      @filenames        = filenames.flatten
      @loaded_filenames = FileUtilities.resolve(@filenames)

      load!
    end

    def load!
      configs = @loaded_filenames.map { |f| FileUtilities.read(f) }

      overlay(configs)
    end
  end
end
