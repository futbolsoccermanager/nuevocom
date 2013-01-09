database_yaml = YAML::load(File.read("#{Rails.root}/config/mongodb.yml"))
puts "Initializing mongodb"

mongo_database = database_yaml[Rails.env]

MongoMapper.connection = Mongo::Connection.new(mongo_database['host'], mongo_database['port'])
MongoMapper.database = mongo_database['database']

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
