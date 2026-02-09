class AddOrderToPayments < ActiveRecord::Migration[8.1]
  def change
    add_reference :payments, :order, null: false, foreign_key: true
  end
end
