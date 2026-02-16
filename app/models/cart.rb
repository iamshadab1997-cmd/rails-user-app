class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy

  validates :total_items, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :calculate_total_items
  after_save :log_cart_update

  private

  def calculate_total_items
    self.total_items ||= 0
  end

  def log_cart_update
    Rails.logger.info "Cart #{id} updated with #{total_items} item(s)"
  end
end
