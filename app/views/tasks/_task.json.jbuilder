json.extract! task, :id, :priority, :description, :state, :created_at, :updated_at
json.url task_url(task, format: :json)
