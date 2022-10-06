require_relative "boot"
require "rails/all"

Bundler.require
require "avatares"

module Dummy
  class Application < Rails::Application
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.load_defaults Rails::VERSION::STRING.to_f

    # Configure the default encoding used in templates for Ruby 1.9.    
    config.encoding = "utf-8"
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
