class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.boolean :approved
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
