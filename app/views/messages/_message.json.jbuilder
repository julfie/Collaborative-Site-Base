json.extract! message, :id, :subject, :body, :invite_code, :sender_id, :recipient_id, :read_status, :send_date, :flagged, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)
