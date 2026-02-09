class Subscription < ApplicationRecord
  belongs_to :user  # Each subscription belongs to a user
  
  # ---------- Callbacks ----------
  before_create :set_active   # Set subscription as active by default
  after_update :log_change    # Log updates after any change

  private

  # Set active to true if not already set
  def set_active
    self.active = true if active.nil?
  end

  # Log a message after update
  def log_change
    Rails.logger.info "Subscription ##{id} updated"
  end
end
