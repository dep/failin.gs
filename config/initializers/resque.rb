Resque.redis = App.redis

require 'resque/server'
if Rails.env.production?
  Resque::Server.use Rack::Auth::Basic do |username, password|
    %w(danny stephen).include?(username) && password == 'dp@VP#09'
  end
end

# resque-retry
require 'resque/failure/redis'
Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
require 'resque-retry/server'
