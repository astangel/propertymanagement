class Lease < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :rent, :renters, :unit_id
  
  belongs_to :unit
  has_many :renters, :class_name => 'User'
end
