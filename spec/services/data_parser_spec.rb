require 'spec_helper'
require_relative '../../app/services/data_parser'
require_relative '../../app/models/user'

describe DataParser do
  describe '#sort' do
    it 'order by a given param' do
      user1 = User.new(name: 'AAA', age: 30, projectcount: 1, totalvalue: 2)
      user2 = User.new(name: 'BBB', age: 31, projectcount: 1, totalvalue: 2)
      users = [user1, user2]
      params = ['name', 'desc']

      expect(described_class.sort(users, params)).to eq([user2, user1])
    end

    it 'raise an error when the type os sort is invalid' do
      user1 = User.new(name: 'AAA', age: 30, projectcount: 1, totalvalue: 2)
      user2 = User.new(name: 'BBB', age: 31, projectcount: 1, totalvalue: 2)
      users = [user1, user2]
      params = ['name', 'invalid_sort']

      expect { described_class.sort(users, params) }
        .to raise_error(ArgumentError, 'Wrong sort argument! use asc|desc')

    end
  end

  describe '#find' do
    it 'returns an array that matches with the search' do
      user1 = User.new(name: 'AAA', age: 30, projectcount: 1, totalvalue: 2)
      user2 = User.new(name: 'BBB', age: 31, projectcount: 1, totalvalue: 2)
      user3 = User.new(name: 'CCC', age: 31, projectcount: 1, totalvalue: 2)
      users = [user1, user2, user3]
      params = ['AAA', 'BBB']

      expect(described_class.find(users, params)).to eq([user1, user2])
    end
  end

  describe '#sum' do
    it 'returns an sum of given parameter' do
      user1 = User.new(name: 'AAA', age: 30, projectcount: 1, totalvalue: 2)
      user2 = User.new(name: 'BBB', age: 31, projectcount: 1, totalvalue: 2)
      users = [user1, user2]
      params = 'age'

      expect(described_class.total(users, params)).to eq(user1.age + user2.age)
    end
  end
end
