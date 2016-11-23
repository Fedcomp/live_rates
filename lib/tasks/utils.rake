task log_to_stdout: :environment do
  logger           = Logger.new(STDOUT)
  logger.level     = Logger::INFO
  Rails.logger     = logger
end
