$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'; Dotenv.load
require 'boot'
require 'socket'
Bundler.require :default, ENV['RACK_ENV']

require 'newrelic_rpm'

$settings = OpenStruct.new YAML.load_file(File.join(File.dirname(__FILE__), '../config/database.yml'))[ENV['RACK_ENV']]

# Require app
require 'app/backend_app'

# Require lib
Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each do |f|
  require f
end

# Require app, model
require 'app/models/init'

# Require api
require_all "api"

require 'app/api'

