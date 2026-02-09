class AddAddressTypeDefaultToAddresses < ActiveRecord::Migration[8.1]
  def change
    change_column :addresses, :address_type, :integer, default: 0
  end
end
exit