json.extract! department, :id, :dep_short_name, :dep_full_name, :created_at, :updated_at
json.url department_url(department, format: :json)
