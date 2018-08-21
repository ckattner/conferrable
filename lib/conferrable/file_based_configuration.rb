#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  class FileBasedConfiguration < Configuration

    attr_reader :filenames, :loaded_filenames

    def initialize(*filenames)
      @filenames        = filenames.flatten
      @loaded_filenames = FileUtilities.resolve(@filenames)

      load!
    end

    def load!
      configs = @loaded_filenames.map { |f| FileUtilities.read(f) }

      super(configs)
    end

  end
end
