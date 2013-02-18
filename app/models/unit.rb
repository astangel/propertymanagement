class Unit < ActiveRecord::Base
  attr_accessible :name, :square_feet, :leases
  
  belongs_to :property
  has_many :leases
end
