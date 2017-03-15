# connection pool size on heroku is 20
# puma has 1 connection
Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end
# 19 others can be used for sidekiq server
Sidekiq.configure_server do |config|
  config.redis = { :size => 17 }
end
