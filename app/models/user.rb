class User < ApplicationRecord
# ---------- ASSOCIATIONS ----------
 has_one  :profile, dependent: :destroy
 accepts_nested_attributes_for :profile, allow_destroy: true
 
  has_one  :cart,    dependent: :destroy

  has_secure_password
validates :password, presence: true, on: :create

  has_many :orders,          dependent: :destroy
  has_many :reviews,         dependent: :destroy
  has_many :notifications,   dependent: :destroy
  has_many :support_tickets, dependent: :destroy
  has_many :wishlists,       dependent: :destroy
  has_many :subscriptions,   dependent: :destroy
  has_many :tickets,         dependent: :destroy
  has_many :audit_logs,      dependent: :destroy
  has_many :blog_posts,      dependent: :destroy
  has_many :events,          dependent: :destroy
  has_many :addresses,       dependent: :destroy
  has_many :products,        dependent: :destroy


  has_many :comments, as: :commentable, dependent: :destroy

  # Messaging system
  has_many :sent_messages,
           class_name: "Message",
           foreign_key: :sender_id,
           dependent: :nullify   # keep messages, set sender_id to NULL

  has_many :received_messages,
           class_name: "Message",
           foreign_key: :receiver_id,
           dependent: :nullify # keep messages, set receiver_id to NULL


  # ---------- ENUMS ----------
  enum :role,   { admin: 0, customer: 1, seller: 2 }, default: "customer"
  enum :status, { inactive: 0, active: 1, banned: 2 }, default: "active"

  # ---------- VALIDATIONS ----------
  validates :name, presence: true, length: { minimum: 3 }

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # ---------- ACTIVE STORAGE ----------
  has_many_attached :documents
  validate :acceptable_documents

  # ---------- CALLBACKS ----------
  before_validation :normalize_email

  # ---------- SCOPES ----------
  scope :active_users, -> { where(status: :active) }
  scope :admins_only,  -> { where(role: :admin) }
  scope :recent,       ->(days = 7) { where("created_at >= ?", days.days.ago) }

  # ---------- CLASS METHODS ----------
  def self.find_by_email(email)
    find_by(email: email.to_s.downcase.strip)
  end

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def acceptable_documents
    return unless documents.attached?

    documents.each do |doc|
      errors.add(:documents, "must be JPEG, PNG, or PDF") unless
        doc.content_type.in?(%w[image/jpeg image/png application/pdf])

      errors.add(:documents, "is too big (max 10MB)") if
        doc.byte_size > 10.megabytes
    end
  end
end
