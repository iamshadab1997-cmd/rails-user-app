class AddCascadeDeleteToUserForeignKeys < ActiveRecord::Migration[8.1]
  def change
    # Orders
    add_foreign_key :orders, :users, on_delete: :cascade, name: "fk_orders_users"

    # Products
    add_foreign_key :products, :users, on_delete: :cascade, name: "fk_products_users"

    # Addresses
    add_foreign_key :addresses, :users, on_delete: :cascade, name: "fk_addresses_users"

    # Wishlists
    add_foreign_key :wishlists, :users, on_delete: :cascade, name: "fk_wishlists_users"

    # Reviews
    add_foreign_key :reviews, :users, on_delete: :cascade, name: "fk_reviews_users"
  end
end
