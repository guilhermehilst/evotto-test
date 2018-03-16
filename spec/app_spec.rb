require 'spec_helper'

describe 'App' do
  it 'calls ArgsParser.parse' do
    stub_const("ARGV", ['--source', 'data/users.csv'])

    expect(ArgsParser).to receive(:parse).and_call_original

    load './app.rb'
  end

  it 'calls CsvParser.parse with the right arguments' do
    stub_const("ARGV", ['--source', 'data/users.csv'])

    expect(CsvParser).to receive(:parse).with('data/users.csv').and_call_original

    load './app.rb'
  end

  it 'calls DataParser.sort when :order_by parameter is given' do
    stub_const("ARGV", ['--source', 'data/users.csv', '--order_by', 'name', 'asc'])

    expect(DataParser).to receive(:sort).and_call_original

    load './app.rb'
  end

  it 'calls DataParser.total when :total parameter is given' do
    stub_const("ARGV", ['--source', 'data/users.csv', '--total', 'age'])

    expect(DataParser).to receive(:total).and_call_original

    load './app.rb'
  end
end
