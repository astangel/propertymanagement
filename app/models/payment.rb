class Payment < ActiveRecord::Base
  attr_accessible :amount, :ip_address, :card_expires_on, :last_name, :first_name, :user, :lease, :user_id, :lease_id, :card_number
  attr_accessor :card_number
  
  validates :amount, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :card_number, :presence => true
  
  validate :validate_card, :on => :create
  
  belongs_to :user
  belongs_to :lease
  has_many :transactions, :class_name => :PaymentTransaction
  
  def make_transaction
    response = GATEWAY.purchase((amount*100), credit_card)
    transactions.create(:response => response)
    response.success?
  end
  
  private
  def credit_card
    @credit_card = ActiveMerchant::Billing::CreditCard.new({
      :first_name => first_name,
      :last_name => last_name,
      :number => card_number,
      :month => card_expires_on.month,
      :year => card_expires_on.year,
      :verification_value => '999'
    })
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
end
