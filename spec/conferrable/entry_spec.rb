# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './spec/spec_helper'

describe Conferrable::Entry do
  let(:default_file_path) { './config/file1.yml.erb' }
  let(:default_abs_file_path) { File.expand_path(default_file_path) }
  let(:default_file) { 'admin: true' }

  before(:each) do
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([default_file_path])
                                                            .and_return([default_abs_file_path])

    allow(IO).to receive(:read).with(default_abs_file_path).and_return(default_file)
  end

  it 'should load default file' do
    entry = Conferrable::Entry.new(:file1)

    admin_value = entry.all['admin']

    expect(admin_value).to be true
  end
end
