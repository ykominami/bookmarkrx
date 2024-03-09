json.extract! user, :id, :name, :image_file_name, :created_at, :updated_at
json.url user_url(user, format: :json)
