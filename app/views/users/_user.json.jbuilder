json.extract! user, :id, :name, :avatar, :team_id, :created_at, :updated_at
json.url user_url(user, format: :json)
