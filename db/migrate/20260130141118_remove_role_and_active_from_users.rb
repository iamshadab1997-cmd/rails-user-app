class RemoveRoleAndActiveFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :role, :string
    remove_column :users, :active, :boolean
  end
end
