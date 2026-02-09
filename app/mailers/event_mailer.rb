class EventMailer < ApplicationMailer
  default from: "noreply@example.com"

  # Email for event creation
  def event_created(event)
    @event = event
    mail(to: @event.user.email, subject: "Event Created!")
  end

  # Email for event update
  def event_updated(event)
    @event = event
    mail(to: @event.user.email, subject: "Event Updated!")
  end
end


