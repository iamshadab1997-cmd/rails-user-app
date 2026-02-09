class Review < ApplicationRecord
  # ---------------- Associations ----------------
  belongs_to :user         # Each review belongs to a user
  belongs_to :product      # Each review belongs to a product

  # ---------------- Validations -----------------
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }  # rating must be 1-5
  validates :comment, presence: true  # comment cannot be blank

  # ---------------- Callbacks -------------------
  before_save :auto_approve  # automatically approve review before saving if rating >= 4

  private

  def auto_approve
    self.approved = true if rating.present? && rating >= 4
  end
end
