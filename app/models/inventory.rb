class Inventory < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :product

  # ---------- VALIDATIONS ----------
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # ---------- CALLBACKS ----------
  before_validation :set_default_quantity, on: :create
  after_update :log_inventory_change

  private

  # Ensure quantity is always >= 0
  def set_default_quantity
    self.quantity ||= 0
  end

  # Log updates for debugging
  def log_inventory_change
    Rails.logger.info "Inventory #{id} for Product #{product_id} updated: quantity=#{quantity}"
  end
end
