class EventMailer < ApplicationMailer
  default from: "amin@example.com"
  layout "mailer"

  def event_created(event)
    @event = event
    attach_banner_if_present

    mail(
      to: @event.user.email,
      subject: "Event Created!"
    )
  end

  def event_updated(event)
    @event = event
    attach_banner_if_present

    mail(
      to: @event.user.email,
      subject: "Event Updated!"
    )
  end

  private

  def attach_banner_if_present
    return unless @event.banner.attached?

    attachments[@event.banner.filename.to_s] =
      @event.banner.download
  rescue ActiveStorage::FileNotFoundError
    Rails.logger.warn "Banner file missing for Event #{@event.id}"
  end
end
