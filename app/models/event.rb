class Event < ApplicationRecord
  belongs_to :user       

  after_create :send_create_email
  after_update :send_update_email

  private

  def send_create_email
    EventMailer.event_created(self).deliver_now
  end

  def send_update_email
    EventMailer.event_updated(self).deliver_now
  end
end
