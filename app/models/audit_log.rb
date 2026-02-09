class AuditLog < ApplicationRecord
  # ================== Associations ==================
  belongs_to :user

  # ================== Callbacks ==================
  after_create :notify_admin      # called after record is created
  after_commit :log_commit        # called after transaction is committed

  private

  # Notify admin (currently logs message, can be extended to email or notification)
  def notify_admin
    Rails.logger.info "AuditLog ##{id} created for User ##{user_id}"
  end

  # Log after commit
  def log_commit
    Rails.logger.info "AuditLog ##{id} committed successfully"
  end
end
