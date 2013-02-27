class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :crypted_password, :password_salt, :persistence_token, :roles, :role_ids, :submittedreports, :approvedreports, :lease_id, :password_confirmation, :lease, :unit, :unit_id
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  belongs_to :lease
  has_one :unit, :through => :lease
  has_many :submittedreports, :class_name => 'RepairRequest'
  has_many :approvedreports, :class_name => 'RepairRequest'
  
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym}
  end
  
  before_create :setup_default_role_for_new_users
 
  def setup_default_role_for_new_users    
      self.roles << Role.where("name='Renter'")
  end
end
