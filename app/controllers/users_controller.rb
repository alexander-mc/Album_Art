class UsersController < ApplicationController

    # CREATE

    get '/signup' do
        redirect to '/albums' if Helpers.is_logged_in?(session)
        erb :'/users/signup'
    end

    post '/signup' do
        user = User.create(params)

        # Validate input
        if !user.valid?
            flash[:signup_error] = user.errors.full_messages
            redirect to '/signup'
        end

        session[:user_id] = user.id
        redirect to '/auth/spotify'
    end

    # READ

    get '/login' do
        redirect to '/albums' if Helpers.is_logged_in?(session)
        erb :'/users/login'
    end

    post '/login' do

        # Case insensitive finder (returns array with one item, hence use of "first")
        # Case sensitive alternative: user = User.find_by('username', params[:username])
        user = User.ci_find('username', params[:username]).first

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/auth/spotify'
        else
            flash[:login_error] = "Sorry, we could not find that username and/or password. Please try again."
            redirect to '/login'
        end

    end

    get '/logout' do
        session.clear if Helpers.is_logged_in?(session)
        redirect to '/'
    end

    # UPDATE

    # DELETE

end