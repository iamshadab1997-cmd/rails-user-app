class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :author_name
      t.string :email
      t.boolean :approved
      t.integer :commentable_id

      t.timestamps
    end
  end
end
