json.extract! project, :id, :owner_id, :proj_description, :genre, :title, :start_date, :end_date, :category, :status, :preview_level, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)
