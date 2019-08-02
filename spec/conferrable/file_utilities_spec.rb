# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './spec/spec_helper'

describe Conferrable::FileUtilities do
  describe 'reading YAML files' do
    it 'returns a parsed YAML and ERB evaluated result for a *.yml.erb file' do
      file_path = File.expand_path('../config_examples/simple.yml.erb', __dir__)
      expected_result = { 'key1' => %w[static_element dynamic_element] }

      expect(described_class.read(file_path)).to eq(expected_result)
    end

    it 'returns a parsed YAML evaluated result for a *.yml file' do
      file_path = File.expand_path('../config_examples/simple.yml', __dir__)
      expected_result = { 'key1' => ['element1', '<%= "ERB which will not evaluate" =>'] }

      expect(described_class.read(file_path)).to eq(expected_result)
    end
  end
end
