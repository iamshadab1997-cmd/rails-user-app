class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message
      t.boolean :read
      t.datetime :sent_at
      t.integer :user_id

      t.timestamps
    end
  end
end
