require 'spec_helper'
require_relative '../../app/services/args_parser'

describe ArgsParser do
  describe '#parse' do
    it 'raise an exception if there is no args' do
      stub_const("ARGV", [])

      expect { described_class.parse }
        .to raise_error(ArgumentError, 'You need to pass some arguments')
    end

    context 'when --source parameter is given' do
      it 'sets options hash with :source key' do
        stub_const("ARGV", ['--source', 'path/to/file.csv'])

        expect(described_class.parse)
          .to eq({source: 'path/to/file.csv'})
      end
    end

    context 'when --order_by parameter is given' do
      it 'sets options hash with :order_by key' do
        stub_const("ARGV", ['--order_by', 'name', 'asc'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

        expect(described_class.parse)
          .to eq({order_by: ['name', 'asc']})
      end

      it 'raise an exception when the number of arguments is different than 2' do
        stub_const("ARGV", ['--order_by', 'name'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

        expect { described_class.parse }
          .to raise_error(ArgumentError, 'Wrong number of arguments for order_by param')
      end
    end

    context 'when --find parameter is given' do
      it 'sets options hash with :find key' do
        stub_const("ARGV", ['--find', 'Name1', 'Name2'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

        expect(described_class.parse)
          .to eq({find: ['Name1', 'Name2']})

      end
    end

    context 'when --total parameter is given' do
      it 'sets options hash with :tota key' do
        stub_const("ARGV", ['--total', 'age'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

        expect(described_class.parse)
          .to eq({total: 'age'})
      end
    end

    context 'when the given parameter is not supported' do
      it 'raise an exception' do
        stub_const("ARGV", ['--wrongparameter', 'age'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

        expect { described_class.parse }
          .to raise_error(ArgumentError, 'Wrong parameter')
      end
    end

    it 'raise an exception when :source parameter is not given' do
      stub_const("ARGV", ['--total', 'age'])

      expect { described_class.parse }
        .to raise_error(ArgumentError, 'Missing --source parameter')
    end

    it 'raise an exception when passing more than 2 parameter' do
      stub_const("ARGV", ['--total', 'age', '--source', 'path/to/file.csv', '--order_by', 'age', 'desc'])

        allow_any_instance_of(Hash)
          .to receive(:has_key?).with(:source).and_return(true)

      expect { described_class.parse }
        .to raise_error(ArgumentError, 'You only can choose 2 params')
    end
  end
end
