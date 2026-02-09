class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.boolean :active
      t.string :slug

      t.timestamps
    end
  end
end
