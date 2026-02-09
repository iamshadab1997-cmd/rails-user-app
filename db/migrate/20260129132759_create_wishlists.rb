class CreateWishlists < ActiveRecord::Migration[8.1]
  def change
    create_table :wishlists do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :user_id
      t.date :created_on

      t.timestamps
    end
  end
end
