require 'active_record'

# establish db connection
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: $settings.db_host,
  database: $settings.db_name,
  username: $settings.db_username,
  password: $settings.db_password
)

# Requires all models
Dir['./models/*.rb'].each { |file| require file }
