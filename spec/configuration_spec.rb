#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './lib/conferrable'

describe Conferrable::Configuration do

  it 'should accept no initialization arguments' do
    config = Conferrable::Configuration.new

    expect(config.all['doesnt_exist']).to be nil
  end

  it 'should accept multiple hashes as initialization arguments' do
    c1 = { 'admin' => true }
    c2 = { 'admin' => false }

    config = Conferrable::Configuration.new(c1, c2)

    expect(config.all['admin']).to be false
  end

  it 'should accept one hash as an initialization argument' do
    config = Conferrable::Configuration.new('admin' => true)

    expect(config.all['admin']).to be true
  end

  it 'should allow get to work with nested depths' do
    c1 = { 'options' => { 'admin' => true } }
    c2 = { 'options' => { 'admin' => false } }

    config = Conferrable::Configuration.new(c1, c2)

    expect(config.all.dig('options', 'admin')).to be false
  end

end
