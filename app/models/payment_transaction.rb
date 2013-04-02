class PaymentTransaction < ActiveRecord::Base
  attr_accessible :response
  serialize :response
  
  
  belongs_to :payment
end
