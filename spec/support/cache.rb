# Cache sensitive test
RSpec.configure do |config|
  config.around cache: :clear do |example|
    Rails.cache.clear # safe
    example.run
    Rails.cache.clear
  end
end
