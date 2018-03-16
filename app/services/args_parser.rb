class ArgsParser
  def self.parse
    raise ArgumentError, 'You need to pass some arguments'  unless ARGV.any?

    options = {}

    while(ARGV.any?)
      arg = ARGV.shift

      case arg
      when "--source"
        options[:source] = ARGV.shift
      when "--order_by"
        options[:order_by] = []
        while (ARGV.any? && !ARGV[0].start_with?("--"))
          options[:order_by] << ARGV.shift
        end
        raise ArgumentError, 'Wrong number of arguments for order_by param' unless options[:order_by].count == 2
      when "--find"
        options[:find] = []
        while (ARGV.any? && !ARGV[0].start_with?("--"))
          options[:find] << ARGV.shift
        end
      when "--total"
        options[:total] = ARGV.shift
      else
        raise ArgumentError, 'Wrong parameter'
      end
    end

    raise ArgumentError, 'Missing --source parameter' unless options.has_key?(:source)
    raise ArgumentError, 'You only can choose 2 params' unless options.size <= 2

    options
  end
end
