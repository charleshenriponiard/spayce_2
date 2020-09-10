# $redis = Redis.new

# url = ENV["REDIS_URL"]

# if url
#   Sidekiq.configure_server do |config|
#     config.redis = { url: url }
#   end

#   Sidekiq.configure_client do |config|
#     config.redis = { url: url }
#   end
#   $redis = Redis.new(:url => url)
# end
if ENV["REDIS_URL"]
    $redis = Redis.new(:url => ENV["REDIS_URL"])
end
