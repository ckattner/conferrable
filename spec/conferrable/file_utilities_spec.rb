# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './spec/spec_helper'

describe Conferrable::FileUtilities do
  let(:config_examples_path) { File.expand_path('../config_examples/', __dir__) }

  describe 'resolving file names' do
    it 'finds all YAML and YAML + ERB files with upper or lower case extensions' do
      expected_files = Set.new([
                                 File.join(config_examples_path, 'full.yaml.erb'),
                                 File.join(config_examples_path, 'full.yaml'),
                                 File.join(config_examples_path, 'simple.yml.erb'),
                                 File.join(config_examples_path, 'simple.yml'),
                                 File.join(config_examples_path, 'UPPER.YML.ERB'),
                                 File.join(config_examples_path, 'UPPER.YML')
                               ])

      expect(Set.new(described_class.resolve(config_examples_path))).to eq expected_files
    end
  end

  describe 'reading/parsing YAML files' do
    it 'returns a parsed YAML evaluated result for a *.yml file' do
      file_path = File.join(config_examples_path, 'simple.yml')
      expected_result = { 'key1' => ['element1', '<%= "ERB which will not evaluate" =>'] }

      expect(described_class.read(file_path)).to eq(expected_result)
    end

    it 'returns a parsed YAML and ERB evaluated result for a *.yml.erb file' do
      file_path = File.join(config_examples_path, 'simple.yml.erb')
      expected_result = { 'key1' => %w[static_element dynamic_element] }

      expect(described_class.read(file_path)).to eq(expected_result)
    end

    it 'returns a parsed YAML and ERB evaluated result for an upper case *.YML.ERB file' do
      file_path = File.join(config_examples_path, 'UPPER.YML.ERB')
      expected_result = { 'key1' => %w[static_element dynamic_element] }

      expect(described_class.read(file_path)).to eq(expected_result)
    end
  end
end
