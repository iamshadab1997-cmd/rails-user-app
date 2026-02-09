class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.string :plan_name
      t.decimal :price
      t.date :start_date
      t.date :end_date
      t.boolean :active

      t.timestamps
    end
  end
end
