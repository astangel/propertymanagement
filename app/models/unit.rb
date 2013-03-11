class Unit < ActiveRecord::Base
  attr_accessible :name, :square_feet, :leases, :property, :property_id, :renters
  
  belongs_to :property
  has_many :leases
  has_many :renters, :class_name => 'User', :through => :leases
  
  def prop_unit
    "#{property.name}: #{name}"
  end
end
