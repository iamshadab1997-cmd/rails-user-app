class CreateSupportTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :support_tickets do |t|
      t.string :subject
      t.text :description
      t.string :priority
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
