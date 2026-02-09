class Notification < ApplicationRecord
  belongs_to :user  # Each notification belongs to a user

  # Callback to set default read status before creation
  before_create :set_default_read

  private

  # Set `read` to false if not specified
  def set_default_read
    self.read = false if read.nil?
  end
end
