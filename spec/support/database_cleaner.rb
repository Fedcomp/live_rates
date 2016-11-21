# Databasecleaner
RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.strategy = if example.metadata[:type] == :feature
                                 :truncation
                               else
                                 :transaction
                               end

    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
