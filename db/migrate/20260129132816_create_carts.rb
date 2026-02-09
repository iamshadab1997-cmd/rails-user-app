class CreateCarts < ActiveRecord::Migration[8.1]
  def change
    create_table :carts do |t|
      t.integer :total_items
      t.decimal :total_price
      t.timestamps   
    end
  end
end
