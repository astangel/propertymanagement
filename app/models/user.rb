class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :crypted_password, :password_salt, :persistence_token
  
  has_many_and_belongs_to_many :roles
  belongs_to :lease
  has_many :submittedreports, :class_name => 'RepairRequest'
  has_many :approvedreports, :class_name => 'RepairRequest'
end
