class Profile < ApplicationRecord
  belongs_to :user

  # Multiple images per profile
  has_many_attached :images

  # ---------- Validations ----------
  validates :phone, presence: true
  validates :bio, length: { maximum: 300 }, allow_blank: true

  # Custom validation for images
  validate :acceptable_images

  private

  # Ensure uploaded images are the correct type and size
  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/jpg image/webp])
        errors.add(:images, "must be JPG or WEBP")
      end

      if image.byte_size > 2.megabytes
        errors.add(:images, "is too big (max 2MB)")
      end
    end
  end
end



