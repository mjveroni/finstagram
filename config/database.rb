configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  if Sinatra::Application.development?
    set :database, {
        adapter: "sqlite3",
        database: "db/db.sqlite3"
    }
  else
    db_url = 'postgres://[postgres://rrmzasnduptptv:ef2c5c79d43d3ceee983adfbe8b1fa2e06ee1ec73e9038b0bfe95c778a402879@ec2-52-45-73-150.compute-1.amazonaws.com:5432/ddjkk6e6u9tnbe]'
    db = URI.parse(ENV]'DATABASE_URL') || db_url)
    set :database, {
        adapater: "postgresql",
        host: db.host,
        username: db.user,
        password: db.password,
        database: db.path[1..-1]
        encoding: 'utf8'
    }
  end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
