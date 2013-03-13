class Lease < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :rent, :renters, :unit_id, :unit, :renter_id, :renter, :prop_unit, :payments, :payment_ids
  
  belongs_to :unit
  has_many :renters, :class_name => 'User'
  has_many :payments
  
  def prop_unit
    "#{unit.property.name}: #{unit.name}"
  end
end
