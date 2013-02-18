class Property < ActiveRecord::Base
  attr_accessible :name, :address, :city, :state, :zip, :units

  has_many :units
end
