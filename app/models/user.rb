class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :crypted_password, :password_salt, :persistence_token, :roles, :submittedreports, :approvedreports, :lease_id, :password_confirmation, :lease, :unit, :unit_id
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  belongs_to :lease
  has_one :unit, :through => :lease
  has_many :submittedreports, :class_name => 'RepairRequest'
  has_many :approvedreports, :class_name => 'RepairRequest'
end
