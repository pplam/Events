class Event < ApplicationRecord
  after_save do |event|
    ActionCable.server.broadcast(
      "event_notifications_channel",
      createdAt: event.created_at,
      userName: event.user.name,
      content: event.content,
      target: event.targetable.send(event.target_field.to_sym),
      result: event.resultable ? event.resultable.send(event.result_field.to_sym) : ''
    )
  end

  belongs_to :targetable, -> { with_deleted }, polymorphic: true
  belongs_to :resultable, polymorphic: true, optional: true
  belongs_to :user
end
