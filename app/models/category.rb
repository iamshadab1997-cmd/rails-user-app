class Category < ApplicationRecord
  # -------------------- ASSOCIATIONS --------------------
  has_and_belongs_to_many :products

  # Active Storage attachment
  has_one_attached :image   # Use `has_many_attached :images` if you want multiple images per category

  # -------------------- VALIDATIONS --------------------
  validates :title, presence: true, uniqueness: true

  # Validate attached image (optional, for type and size)
  validate :acceptable_image

  # -------------------- CALLBACKS --------------------
  before_save :normalize_title

  private

  # Capitalize and strip title before saving
  def normalize_title
    self.title = title.strip.titleize if title.present?
  end

  # Validate image type and size
  def acceptable_image
    return unless image.attached?

    unless image.content_type.in?(%w[image/jpeg image/jpg image/webp png])
      errors.add(:image, "must be JPG, JPEG, PNG, or WEBP")
    end

    if image.byte_size > 2.megabytes
      errors.add(:image, "size must be less than 2MB")
    end
  end
end
