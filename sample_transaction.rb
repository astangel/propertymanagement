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
  :number     => '4111111111111111',
  :month      => '10',
  :year       => (Time.now.year + 1).to_s,
  :verification_value => '999'
})


# BEGIN purchase
if credit_card.valid?

	response = gateway.purchase(22800, credit_card)
	
	if response.success?
		puts "The transaction was successful!  The authorization is #{response.authorization}"
		puts response.params
	else
		puts "The transaction was unsuccessful because #{response.message}"
	end
	
else
	puts "The credit card is invalid"
end