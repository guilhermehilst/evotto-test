require 'active_model'

class User
  include ActiveModel::Model

  attr_accessor :name, :age, :projectcount, :totalvalue
end
