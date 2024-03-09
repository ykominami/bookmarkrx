json.extract! bookmark, :id, :href, :desc, :add_date, :last_modified, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)
