class EventNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
