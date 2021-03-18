require_relative 'boot'

require 'rails/all'
require 'csv'
require 'yaml'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoromandelHarleyDavidson
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

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
      config.assets.initialize_on_precompile = true

      config.api_only = false
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/uploaders)
    # config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :options]
      end
    end

    config.action_dispatch.default_headers.merge!({
                                                    'Access-Control-Allow-Origin' => '*',
                                                    'Access-Control-Request-Method' => '*'
                                                  })
  end
end
