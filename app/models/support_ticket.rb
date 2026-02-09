class SupportTicket < ApplicationRecord
  # Each ticket belongs to a user
  belongs_to :user

  # Before updating a ticket, check if it's already closed
  before_update :lock_closed_ticket

  private

  # Prevent changing the status if the ticket is already closed
  def lock_closed_ticket
    if status_was == "closed"          # status_was gives previous value before update
      errors.add(:status, "cannot be changed once closed")
      throw(:abort)                    # stop the update
    end
  end
end
