require 'active_record'

# establish db connection
ActiveRecord::Base.establish_connection(
  adapter: $settings.db_adapter,
  host: $settings.db_host,
  database: $settings.db_name,
  username: $settings.db_username,
  password: $settings.db_password
)

# Requires all models
require_all './app/models'
