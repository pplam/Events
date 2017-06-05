json.extract! todo, :id, :content, :deadline, :status, :project_id, :creator_id, :executor_id, :created_at, :updated_at
json.url todo_url(todo, format: :json)
