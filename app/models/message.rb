class Message < ApplicationRecord
  # ---------- ASSOCIATIONS ----------
  belongs_to :sender,   class_name: "User", foreign_key: "sender_id",   optional: true
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id", optional: true

  # ---------- VALIDATIONS ----------
  validates :body, presence: true

  # ---------- CALLBACKS ----------
  before_save :sanitize_body
  after_commit :notify_receiver, on: :create

  private

  # Remove leading/trailing spaces from message
  def sanitize_body
    self.body = body.strip if body.present?
  end

  # Dummy notification to log that a message was sent
  def notify_receiver
    Rails.logger.info "Message ##{id} sent to User ##{receiver_id}"
  end
end
