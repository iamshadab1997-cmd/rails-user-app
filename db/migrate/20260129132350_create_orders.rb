class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.decimal :total_amount
      t.string :status
      t.datetime :placed_at
      t.integer :user_id

      t.timestamps
    end
  end
end
