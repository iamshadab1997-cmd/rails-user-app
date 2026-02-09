class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :read
      t.datetime :sent_at

      t.timestamps
    end
  end
end
