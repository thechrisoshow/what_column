$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'what_column'
require 'what_column_migrator'

# Load the environment
ENV['RAILS_ENV'] ||= 'test'

rails_root = File.dirname(__FILE__) + '/rails_root'

require "#{rails_root}/config/environment.rb"


# Load the testing framework
require 'test_help'

# Run the migrations

ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")


require 'shoulda'