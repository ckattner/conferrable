# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Conferrable
  # Base class that defines main hash-based implementation.
  class Configuration
    attr_reader :all

    def initialize(*configs)
      @all = {}

      overlay(configs)
    end

    def overlay(*configs)
      configs.flatten.compact.each { |config| @all.merge!(config || {}) }

      nil
    end
  end
end
