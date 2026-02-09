class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.string :seat_number
      t.decimal :price
      t.string :status
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
