class Payment < ApplicationRecord
  belongs_to :order

  validates :amount, numericality: { greater_than: 0 }
  validates :payment_method, presence: true

  after_create :update_order_status

  private

  def update_order_status
    order.update!(status: "paid")
  end
end
