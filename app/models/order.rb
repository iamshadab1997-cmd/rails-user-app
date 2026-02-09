class Order < ApplicationRecord
  belongs_to :user

  # One order can have many payments
  has_many :payments, dependent: :destroy

  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  before_create :set_order_number
  after_create :notify_user

  private

  def set_order_number
    self.order_number ||= "ORD-#{SecureRandom.hex(4)}"
  end

  def notify_user
    Notification.create(user: user, title: "Order Placed", message: "Your order #{order_number} has been placed")
  end
end
