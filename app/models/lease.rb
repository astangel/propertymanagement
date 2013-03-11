class Lease < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :rent, :renters, :unit_id, :unit, :renter_id, :renter, :prop_unit
  
  belongs_to :unit
  has_many :renters, :class_name => 'User'
  
  def prop_unit
    "#{unit.property.name}: #{unit.name}"
  end
end
