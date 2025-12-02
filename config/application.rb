require_relative 'boot'

# Load Rails components individually (excluding activerecord since we use Couchbase via couchbase-orm)
require 'rails'
%w(
  action_controller
  action_view
  action_mailer
  active_job
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

# Excluded components (using Couchbase instead of ActiveRecord):
# - active_record/railtie - Using Couchbase via couchbase-orm
# - active_storage/engine - Not needed for API-only app
# - action_cable/railtie - Not using WebSockets

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load environment variables from dev.env in development and test environments
if ENV['RAILS_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load('dev.env')
end

module RubyCouchbaseOrmQuickstart
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoloader = :classic
    config.autoload_paths += %W[#{config.root}/lib]
  end
end
