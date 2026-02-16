class Review < ApplicationRecord
  # ---------------- Associations ----------------
  belongs_to :user
  belongs_to :product

  # ---------------- Validations -----------------
  validates :rating,
            presence: true,
            inclusion: { in: 1..5 }

  validates :title, presence: true
  validates :reviewer_name, presence: true
  validates :comment, presence: true

  # ---------------- Callbacks -------------------
  before_save :auto_approve

  private

  def auto_approve
    self.approved = true if rating.present? && rating >= 4
  end
end
