
######################################
# Main
######################################

task :environment do
  ENV["RACK_ENV"] ||= 'development'
  require File.expand_path("../config/environment", __FILE__)
end

desc 'Print compiled grape routes'
task :routes => :environment do
  Backend::API.routes.each do |route|
    puts route
  end
end

Dir.glob('lib/tasks/*.rake').each { |r| load r}

######################################
# DB
######################################
namespace :db do

  def connect(conf)
    conf = OpenStruct.new(conf)
    ActiveRecord::Base.establish_connection(
      adapter: "mysql2",
      host: conf.db_host,
      database: conf.db_name,
      username: conf.db_username,
      password: conf.db_password
    )
  end

  desc "Setup the db, create, migrate and seed"
  task :setup => [ :environment, :create, :migrate, :seed ]

  desc "Seeds data"
  task :seed => :environment do
    load('db/seeds.rb')
  end

  desc "Drops the database for the current RACK_ENV"
  task :drop => :environment do
    config = YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
    db_name = config.delete('db_name')
    connect(config)
    ActiveRecord::Base.connection.drop_database(db_name)
  end

  desc "Create the database defined in config/database.yml for the current RACK_ENV"
  task :create => :environment do
    config = YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
    db_name = config.delete('db_name')
    connect(config)
    ActiveRecord::Base.connection.create_database(db_name)
  end

  desc "migrate your database"
  task :migrate => :environment do
    config = YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
    connect(config)
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
  end

  desc "create an ActiveRecord migration in ./db/migrate"
  task :create_migration => :environment do
    name = ENV['NAME']
    abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name

    migrations_dir = File.join("db", "migrate")
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S") 
    filename = "#{version}_#{name}.rb"
    migration_name = name.gsub(/_(.)/) { $1.upcase }.gsub(/^(.)/) { $1.upcase }

    FileUtils.mkdir_p(migrations_dir)

    open(File.join(migrations_dir, filename), 'w') do |f|
      f << (<<-EOS).gsub("      ", "")
      class #{migration_name} < ActiveRecord::Migration
        def self.up
        end

        def self.down
        end
      end
      EOS
    end
    puts "#{File.join(migrations_dir, filename)}"
  end

  namespace :migrate do
    desc 'Runs the "down" for a given migration VERSION'
    task(:down => :environment) do
      ActiveRecord::Migrator.down('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end

    desc 'Runs the "up" for a given migration VERSION'
    task(:up => :environment) do
      ActiveRecord::Migrator.up('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end

    desc "Rollbacks the database one migration and re migrate up"
    task(:redo => :environment) do
      ActiveRecord::Migrator.rollback('db/migrate', 1 )
      ActiveRecord::Migrator.up('db/migrate', nil )
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
  end

  namespace :schema do
    task :dump => :environment do
      require 'active_record/schema_dumper'
      File.open(ENV['SCHEMA'] || "db/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end
end

######################################
# Rspec
######################################

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/api/*_spec.rb', 'spec/models/**/*_spec.rb']
end

######################################
# Annotate
######################################

namespace :annotate do

  desc "Annotate the models"
  task :create => :environment do
    `annotate --model-dir #{File.join(File.dirname(__FILE__), 'models')}`
  end

  desc "delete the annoatation of the models"
  task :delete => :environment do
    `annotate -d --model-dir #{File.join(File.dirname(__FILE__), 'models')}`
  end

end
