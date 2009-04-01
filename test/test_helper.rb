# Load the environment
ENV['RAILS_ENV'] = 'test'

rails_root = File.dirname(__FILE__) + '/rails_root'

require "#{rails_root}/config/environment.rb"

# Load the testing framework
require 'test_help'
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

# Run the migrations

ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")
# ActiveRecord::Migrator.migrate("#{RAILS_ROOT_FOR_PLUGIN}/db/migrate")

require 'shoulda'