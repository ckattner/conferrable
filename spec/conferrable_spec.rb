# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './lib/conferrable'

describe Conferrable do
  let(:default_file_path) { './config/file1.yml.erb' }
  let(:default_abs_file_path) { File.expand_path(default_file_path) }

  let(:default_file) { 'admin: true' }

  before(:each) do
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([default_file_path])
                                                            .and_return([default_abs_file_path])

    allow(IO).to receive(:read).with(default_abs_file_path).and_return(default_file)
  end

  after(:each) do
    Conferrable.clear!
  end

  it 'should load default file using brackets method' do
    admin_value = Conferrable[:file1]['admin']

    expect(admin_value).to be true
  end

  it 'should load default file using get method' do
    admin_value = Conferrable.get(:file1)['admin']

    expect(admin_value).to be true
  end

  it 'should load default file using get_* method_missing' do
    admin_value = Conferrable.get_file1['admin']

    expect(admin_value).to be true
  end

  it 'should set the filenames and load the correct file' do
    Conferrable.set_filenames(:another_file, default_file_path)

    admin_value = Conferrable.get_another_file['admin']

    expect(admin_value).to be true
  end

  it 'should not allow you to change the filenames after its used the first time' do
    admin_value = Conferrable.get_file1['admin']
    expect(admin_value).to be true

    expect do
      Conferrable.set_filenames(:file1, 'something_else.yml.erb')
    end.to raise_error(ArgumentError)
  end
end
