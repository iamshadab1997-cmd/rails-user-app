class AddUserToSubscriptions < ActiveRecord::Migration[8.1]
  def change
    add_reference :subscriptions, :user, null: false, foreign_key: true
  end
end
