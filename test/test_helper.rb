# Load the environment
ENV['RAILS_ENV'] = 'test'

RAILS_ROOT_FOR_PLUGIN = File.dirname(__FILE__) + '/rails_root'

require "#{RAILS_ROOT_FOR_PLUGIN}/config/environment.rb"

# Load the testing framework
require 'test_help'
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

# Run the migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")

require 'shoulda'