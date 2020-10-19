require_relative './config/environment'

# require 'rspotify/oauth'
# require 'omniauth'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end


# Rails.application.config.middleware.use OmniAuth::Builder do
#     provider :spotify, client_id, client_secret, scope: "user-read-recently-played user-read-email playlist-modify-public user-library-read user-library-modify"
# end

# use Rack::Session::Cookie
# use OmniAuth::Strategies::Spotify


# require 'sinatra'
# require 'omniauth-spotify'

# use OmniAuth::Builder do
#     provider :spotify, client_id, client_secret, scope: "user-read-recently-played user-read-email playlist-modify-public user-library-read user-library-modify"
# end

# if ActiveRecord::Migrator.needs_migration?
#     raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use Rack::MethodOverride

run ApplicationController
use UsersController
use SetupsController
use AlbumsController
