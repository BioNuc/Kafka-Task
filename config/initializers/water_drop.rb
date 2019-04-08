WaterDrop.setup do |config|
  config.kafka.seed_brokers = [Rails.env.production? ? 'TBD' : 'kafka://localhost:9092']
  config.deliver = true
  config.logger = Logger.new($stdout, level: Logger::WARN)
end