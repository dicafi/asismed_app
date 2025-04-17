json.extract! user, :id, :username, :password_digest, :profile, :last_name, :second_last_name,
:first_name, :signature, :active, :created_at, :updated_at
json.url user_url(user, format: :json)
