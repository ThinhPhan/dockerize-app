# ...

module Drkiq
  class Application < Rails::Application
    config.load_defaults 7.0

    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

    # gem 'redis-rails', '~> 5.0.2'
    config.cache_store = :redis_store, ENV['CACHE_URL'],
                        { namespace: 'APP_NAME::cache' }

    # gem 'sidekiq', '~> 6.4.2'
    config.active_job.queue_adapter = :sidekiq
  end
end
