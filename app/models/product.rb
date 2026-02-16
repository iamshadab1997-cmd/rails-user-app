class Product < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :inventories, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :wishlist_items
  has_many :wishlists, through: :wishlist_items
  has_many :cart_items, dependent: :destroy

  # ---------- ACTIVE STORAGE ----------
  has_many_attached :images

  # ---------- VALIDATIONS ----------
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :acceptable_images

  # ---------- CALLBACKS ----------
  before_validation :set_default_stock
  after_create :log_product_creation
  after_commit :audit_product_change

  private

  def set_default_stock
    self.stock ||= 0
  end

  def log_product_creation
    Rails.logger.info "Product #{id} (#{name}) created"
  end

  def audit_product_change
    AuditLog.create(
      user_id: user_id,
      action: "product_changed",
      record_type: "Product",
      record_id: id
    )
  end

  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/webp])
        errors.add(:images, "must be JPG, JPEG, PNG, or WEBP")
      end

      if image.byte_size > 5.megabytes
        errors.add(:images, "size must be less than 5MB")
      end
    end
  end
end
