require_relative 'app/services/args_parser'
require_relative 'app/services/csv_parser'
require_relative 'app/services/data_parser'

class App
  class << self
    def init
      options = ArgsParser.parse
      users = CsvParser.parse(options[:source])

      arg = options.except(:source)
      list(users) if arg.empty?
      arg.each_pair do |key, param|
        case key
        when :order_by
          list(DataParser.sort(users, param))
        when :total
          response =  DataParser.total(users, param)
          puts "#{param}: #{response}"
        when :find
          list(DataParser.find(users, param))
        end
      end

    end

    private

    def list(response)
      puts "Name | Age | ProjectCount | TotalValue"
      if response.empty?
        puts "No user found! try again"
      else
        response.each do |user|
          puts "#{user.name} | #{user.age} | #{user.projectcount} | #{user.totalvalue}"
        end
      end
    end
  end
end

App.init
