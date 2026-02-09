class CreateInventories < ActiveRecord::Migration[8.1]
  def change
    create_table :inventories do |t|
      t.string :sku
      t.integer :quantity
      t.string :warehouse_location
      t.integer :restock_level
      t.boolean :active

      t.timestamps
    end
  end
end
