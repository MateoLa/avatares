# Configure Rails Envinronment
ENV['RAILS_ENV'] ||= 'test'

require_relative "../spec/dummy/config/environment"
require "rails/test_help"
require "rspec/rails"

Rails.backtrace_cleaner.remove_silencers!

# Run any available migration
ActiveRecord::MigrationContext.new(File.expand_path('../dummy/db/migrate', __FILE__)).migrate
