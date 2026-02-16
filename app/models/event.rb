class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :banner

  after_commit :send_create_email, on: :create
  after_commit :send_update_email, on: :update

  private

  def send_create_email
    EventMailer.event_created(self).deliver_later
  end

  def send_update_email
    EventMailer.event_updated(self).deliver_later
  end
end
