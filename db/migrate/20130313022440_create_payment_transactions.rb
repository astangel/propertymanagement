class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.text :response
      t.integer :payment_id

      t.timestamps
    end
  end
end
