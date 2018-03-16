require 'spec_helper'
require_relative '../../app/services/csv_parser'

describe CsvParser do
  describe '#parse' do
    it 'parse an json and return an array of users' do
      csv_rows = "name,age,projectcount,totalvalue\nGuiherme,31,1,99\n"

      allow(File).to receive(:read).and_return(csv_rows)

      expect(described_class.parse('path/to/file.csv')).to all(be_a(User))
    end
  end
end
