class Cart < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :user

  # ---------- VALIDATIONS ----------
  validates :total_items, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # ---------- CALLBACKS ----------
  before_save :calculate_total_items
  after_save :log_cart_update

  private

  # Ensure total_items defaults to 0 if nil
  def calculate_total_items
    self.total_items ||= 0
  end

  # Log cart updates
  def log_cart_update
    Rails.logger.info "Cart #{id} updated with #{total_items} item(s)"
  end
end
