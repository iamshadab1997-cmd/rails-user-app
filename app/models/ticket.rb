class Ticket < ApplicationRecord
  # ---------- Associations ----------
  belongs_to :event   # Each ticket belongs to an event
  belongs_to :user    # Each ticket belongs to a user (buyer)

  # ---------- Callbacks ----------
  before_save :normalize_seat_number  # Normalize seat before saving
  after_create :log_ticket_purchase   # Log info after ticket is created

  private

  # Converts seat_number to uppercase to maintain consistency
  def normalize_seat_number
    self.seat_number = seat_number.upcase if seat_number.present?
  end

  # Logs ticket purchase info for debugging or auditing
  def log_ticket_purchase
    Rails.logger.info "Ticket ##{id} purchased for Event ##{event_id} by User ##{user_id}"
  end
end
