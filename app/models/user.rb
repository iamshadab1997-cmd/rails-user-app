class User < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true

  has_one :cart, dependent: :destroy

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
           dependent: :nullify

  has_many :received_messages,
           class_name: "Message",
           foreign_key: :receiver_id,
           dependent: :nullify

  # ---------- AUTH ----------
  has_secure_password

  # ---------- ENUMS ----------
  enum :role,   { admin: 0, customer: 1, seller: 2 }, default: "customer"
  enum :status, { inactive: 0, active: 1, banned: 2 }, default: "active"

  # ---------- VALIDATIONS ----------
  validates :name, presence: true, length: { minimum: 3 }

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, on: :create

  # ---------- ACTIVE STORAGE ----------
  has_many_attached :documents
  validate :acceptable_documents

  # ---------- CALLBACKS ----------
  before_validation :normalize_email
  after_create :create_cart_for_user

  # ---------- SCOPES ----------
  scope :active_users, -> { where(status: :active) }
  scope :admins_only,  -> { where(role: :admin) }
  scope :recent,       ->(days = 7) { where("created_at >= ?", days.days.ago) }

  # ---------- CLASS METHODS ----------
  def self.find_by_email(email)
    find_by(email: email.to_s.downcase.strip)
  end

  # ---------- PRIVATE METHODS ----------
  private

  # Auto create cart for every new user
  def create_cart_for_user
    create_cart(total_items: 0, total_price: 0) unless cart.present?
  end

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def acceptable_documents
    return unless documents.attached?

    documents.each do |doc|
      unless doc.content_type.in?(%w[image/jpeg image/png application/pdf])
        errors.add(:documents, "must be JPEG, PNG, or PDF")
      end

      if doc.byte_size > 10.megabytes
        errors.add(:documents, "is too big (max 10MB)")
      end
    end
  end
end
