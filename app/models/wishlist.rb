class Wishlist < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
   belongs_to :user
  has_many :wishlist_items, dependent: :destroy
  has_many :products, through: :wishlist_items

  # ---------- VALIDATIONS ----------
  validates :name, presence: true

  # ---------- CALLBACKS ----------
  before_validation :capitalize_name
  after_create :log_creation

  private

  # Capitalize the wishlist name before saving
  def capitalize_name
    self.name = name.to_s.titleize if name.present?
  end

  # Log creation of wishlist
  def log_creation
    Rails.logger.info "Wishlist ##{id} created for User ##{user_id}"
  end
end
