class MakeMessageUsersNullable < ActiveRecord::Migration[8.1]
  def change
    # Allow sender_id and receiver_id to be NULL
    change_column_null :messages, :sender_id, true
    change_column_null :messages, :receiver_id, true
  end
end
