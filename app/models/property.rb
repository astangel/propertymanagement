class Property < ActiveRecord::Base
  att_accessible :name, :address, :city, :state, :zip

  has_many :units
end
