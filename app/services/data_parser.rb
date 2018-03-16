class DataParser
  def self.sort(users, params)
    case params[1]
    when 'asc'
      users.sort_by {|user| user.send(params[0].to_sym) }
    when 'desc'
      users.sort_by {|user| user.send(params[0].to_sym) }.reverse
    else
      raise ArgumentError, 'Wrong sort argument! use asc|desc'
    end
  end

  def self.find(users, params)
    users.select{ |user| user.name.match(Regexp.union(params)) }
  end

  def self.total(users, param)
    sum = 0

    users.each do |user|
      sum += user.send(param.downcase.to_sym).to_i
    end

    sum
  end
end
