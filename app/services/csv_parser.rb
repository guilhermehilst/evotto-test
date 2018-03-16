require 'csv'
require_relative '../models/user'

class CsvParser
  def self.parse(source)
    csv_source = File.read(source)
    csv = CSV.parse(csv_source,
                    :headers => true,
                    :header_converters => lambda { |h| h.downcase })
    users = []
    csv.each do |row|
      users << User.new(row.to_hash)
    end
    users
  end
end
