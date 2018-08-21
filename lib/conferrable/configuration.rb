#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  class Configuration

    def initialize(*configs)
      load!(configs)
    end

    def all
      @all || {}
    end

    def load!(*configs)
      configs.flatten.compact.each { |c| overlay(c) }

      nil
    end

    private

    def overlay(config)
      @all = {} unless @all

      @all.merge!(config || {})
    end

  end
end
