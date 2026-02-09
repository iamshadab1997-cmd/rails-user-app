class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.text :bio
      t.string :phone
      t.string :gender
      t.date :dob
      t.integer :user_id

      t.timestamps
    end
  end
end
