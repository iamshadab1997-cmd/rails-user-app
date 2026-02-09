class AddressesController < ApplicationController
  # Show all addresses
  def index
    @addresses = Address.all.includes(:user) # eager load users to avoid N+1 queries
  end
end
