class AddAddressToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :address, :string
  end
end
