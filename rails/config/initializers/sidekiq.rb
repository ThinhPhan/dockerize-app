sidekiq_config = {
  url: ENV['JOB_WORKER_URL'],
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT'] || '6379'
}

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
