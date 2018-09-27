#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './lib/conferrable'

describe Conferrable::FileBasedConfiguration do

  let(:file1_path) { File.expand_path('spec/files/file1.yml.erb') }
  let(:file2_path) { File.expand_path('spec/files/file2.yml.erb') }
  let(:files_path) { File.expand_path('spec/files') }
  let(:files) { [ file1_path, file2_path ]}

  let(:file1) { "admin: true" }
  let(:file2) { "admin: false" }

  before(:each) do
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([]).and_return([])
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([file1_path]).and_return([file1_path])
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([file2_path]).and_return([file2_path])
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([files_path]).and_return(files)
    allow(::Conferrable::FileUtilities).to receive(:resolve).with([files]).and_return(files)
    allow(::Conferrable::FileUtilities).to receive(:resolve).with(files).and_return(files)

    allow(IO).to receive(:read).with(file1_path).and_return(file1)
    allow(IO).to receive(:read).with(file2_path).and_return(file2)
  end

  it 'should allow no files' do
    config = Conferrable::FileBasedConfiguration.new

    admin_value = config.all['admin']

    expect(admin_value).to be nil
  end

  it 'should load single file' do
    config = Conferrable::FileBasedConfiguration.new(file1_path)

    admin_value = config.all['admin']

    expect(admin_value).to be true
  end

  it 'should load multiple files' do
    # Test passing in an array
    config = Conferrable::FileBasedConfiguration.new(files)
    admin_value = config.all['admin']
    expect(admin_value).to be false

    # Test passing in multiple arguments
    config = Conferrable::FileBasedConfiguration.new(*files)
    admin_value = config.all['admin']
    expect(admin_value).to be false

    # Test passing in an nested arrays
    config = Conferrable::FileBasedConfiguration.new([ [ files ] ])
    admin_value = config.all['admin']
    expect(admin_value).to be false
  end

  it 'should load directories' do
    config = Conferrable::FileBasedConfiguration.new(files_path)
    admin_value = config.all['admin']

    expect(admin_value).to be false
    expect(config.loaded_filenames).to eq(files)
  end

end
