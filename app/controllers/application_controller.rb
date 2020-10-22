require 'rack-flash'

class ApplicationController < Sinatra::Base

    configure do # What is the purpose of this, since no ENV is passed through as an argument?
        set :views, 'app/views'
        set :public_folder, 'public' # What does this do?
        set :sessions, true
        set :session_secret, ENV["SESSION_SECRET"]
    end

    use Rack::Flash

    scope = "user-read-recently-played
             user-read-email
             playlist-modify-public
             user-library-read
             user-library-modify
             user-modify-playback-state
             app-remote-control
             streaming"

    use OmniAuth::Builder do
        provider :spotify, ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], scope: scope
    end

    get '/' do
        erb :index
    end

    get '/auth/spotify/callback' do
        # Stores Spotify credentials in session
        session[:credentials] = request.env['omniauth.auth']

        Helpers.load_songs(session)
        
        redirect to '/setup' if Helpers.current_user(session).setup.nil?
        redirect to '/albums'
    end

end