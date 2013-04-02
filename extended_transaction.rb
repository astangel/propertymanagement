require 'rubygems'
require 'active_merchant'

# Use the test server
ActiveMerchant::Billing::Base.mode = :test

# Construct a gateway
gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new({
  :login    => '5f8Ygta6D4UP',
  :password => '464sH68yF94w8gGR'
})

# Create a credit card object
credit_card = ActiveMerchant::Billing::CreditCard.new({
  :first_name => 'Rob',
  :last_name  => 'Elliott',
  :number     => '6011000000000012',
  :month      => '10',
  :year       => (Time.now.year + 1).to_s,
  :verification_value => '999'
})

# Create an array of options
options = {
  	:billing_address => {
    :name     => 'Rob Elliott',
    :address1 => '1234 Shady Brook Lane',
    :address2 => 'Apartment 1',
    :city     => 'Indianapolis',
    :state    => 'IN',
    :country  => 'US',
    :zip      => '46240',
    :phone    => '555-555-5555'
  },
  :description => 'Rent payment',
  :invoice => '12345678'
}

# BEGIN purchase
if credit_card.valid?

	response = gateway.purchase(120000, credit_card, options)
	
	if response.success?
		puts "The transaction was successful!  The authorization is #{response.authorization}"
		puts response.params
	else
		puts "The transaction was unsuccessful because #{response.message}"
		puts response.params
	end
	
else
	puts "The credit card is invalid"
end