# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

run Sinatra::Application

configure do

enable :sessions

set :session_secret, ENV['SESSION_SECRET'] || 'secret'

set :views, File.join(Sinatra::Application.root, "app", "views")
end