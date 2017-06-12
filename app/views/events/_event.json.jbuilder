json.extract! event, :id, :content, :targetable_id, :targetable_type, :resultable_id, :resultable_type, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
