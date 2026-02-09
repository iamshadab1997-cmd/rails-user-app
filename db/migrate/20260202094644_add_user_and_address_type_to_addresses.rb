class AddUserAndAddressTypeToAddresses < ActiveRecord::Migration[8.1]
  def change
    # Add user reference if it doesn't exist
    add_reference :addresses, :user, null: false, foreign_key: true unless column_exists?(:addresses, :user_id)

    # Add address_type column if it doesn't exist
    add_column :addresses, :address_type, :integer, default: 0 unless column_exists?(:addresses, :address_type)
  end
end
