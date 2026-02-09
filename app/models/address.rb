class Address < ApplicationRecord
  belongs_to :user

  # ------------------ ACTIVE STORAGE ------------------
  has_many_attached :attachments   # Can be images, PDFs, etc.

  # ------------------ ENUM ------------------
  enum :address_type, { home: 0, office: 1, other: 2 }

  # ------------------ VALIDATIONS ------------------
  validates :street, presence: true, length: { minimum: 5 }
  validates :city, :state, :country, presence: true
  validates :postal_code,
            presence: true,
            numericality: { only_integer: true },
            length: { is: 6 }

  validate :acceptable_attachments   # custom validation for attachments

  # ------------------ CALLBACKS ------------------
  before_validation :normalize_fields
  before_save :capitalize_city_state

  private

  def normalize_fields
    self.city    = city.to_s.strip
    self.state   = state.to_s.strip
    self.country = country.to_s.strip
  end

  def capitalize_city_state
    self.city  = city.titleize
    self.state = state.titleize
  end

  # ------------------ ATTACHMENT VALIDATION ------------------
  def acceptable_attachments
    return unless attachments.attached?

    attachments.each do |att|
      unless att.content_type.in?(%w[image/jpeg image/jpg image/png application/pdf])
        errors.add(:attachments, "must be JPG, PNG, or PDF")
      end

      if att.byte_size > 5.megabytes
        errors.add(:attachments, "size must be less than 5MB")
      end
    end
  end
end



