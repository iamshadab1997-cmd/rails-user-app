class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :payment_method
      t.string :status
      t.string :transaction_id
      t.datetime :paid_at

      t.timestamps
    end
  end
end
