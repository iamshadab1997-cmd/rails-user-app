class Product < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :user             # Connect product to a user (seller)
  has_many :reviews, dependent: :destroy
  has_many :inventories, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :wishlist_items
  has_many :wishlists, through: :wishlist_items

  # Active Storage attachments
  has_many_attached :images     # ✅ allows multiple images/files per product

  # ---------- VALIDATIONS ----------
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Custom validation for attached images
  validate :acceptable_images

  # ---------- CALLBACKS ----------
  before_validation :set_default_stock
  after_create :log_product_creation
  after_commit :audit_product_change

  # ---------- METHODS ----------
  private

  # Ensure stock is always an integer >= 0
  def set_default_stock
    self.stock ||= 0
  end

  # Simple logging after creation
  def log_product_creation
    Rails.logger.info "Product #{id} (#{name}) created"
  end

  # Audit every change
  def audit_product_change
    AuditLog.create(
      user_id: user_id,                  # associate with seller
      action: "product_changed",
      record_type: "Product",
      record_id: id
    )
  end

  # Validate attached images
  def acceptable_images
    return unless images.attached?

    images.each do |image|
      # ✅ Content type validation
      unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/webp])
        errors.add(:images, "must be JPG, JPEG, PNG, or WEBP")
      end

      # ✅ Size validation
      if image.byte_size > 5.megabytes
        errors.add(:images, "size must be less than 5MB")
      end
    end
  end
end



