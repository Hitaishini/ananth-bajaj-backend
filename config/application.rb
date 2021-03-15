require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoromandelHarleyDavidson
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.

    # don't generate RSpec tests for views and helpers
      config.generators do |g|
        g.test_framework :rspec, fixture: true
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.view_specs false
        g.helper_specs false
        g.stylesheets = false
        g.javascripts = false
        g.helper = false
      end

      config.active_job.queue_adapter = :delayed_job

      config.api_only = false


      # config.time_zone = 'Chennai'
      # config.active_record.default_timezone = 'Chennai'

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/uploaders)
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, "Rack::Cors" do
        allow do
            origins '*'
            resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :options]
        end
    end

    config.action_dispatch.default_headers.merge!({
                                                    'Access-Control-Allow-Origin' => '*',
                                                    'Access-Control-Request-Method' => '*'
                                                  })
    # config.action_dispatch.default_headers = { 'Access-Control-Allow-Origin' => 'http://coromandal.myridz.com.s3-website-us-east-1.amazonaws.com', 'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")}
  end
end
