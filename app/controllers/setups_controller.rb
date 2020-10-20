class SetupsController < ApplicationController

    # CREATE / READ / UDPATE
    # Create and read views were almost the same, so I've merged the two routes/views

    get '/setup' do
        redirect to '/login' unless Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        erb :'/setup/index'
    end

    post '/setup' do
        user = Helpers.current_user(session)
        num_songs_needed = params[:rows].to_i * params[:columns].to_i
        
        user.create_setup(params)

        # Validate input
        if !user.setup.valid?
            flash[:setup_error] = user.setup.errors.full_messages
            redirect to '/setup'
        elsif user.songs.count < num_songs_needed
            flash[:setup_error] = Array("This setup requires #{num_songs_needed} songs. Please adjust the number of columns/rows or click on 'Refresh' to see if any more songs can be loaded from Spotify (songs loaded in the past will not be deleted).")
            redirect to '/setup'
        end

        redirect to '/albums/edit'
    end

    get '/setup/refresh' do
        redirect to '/login' unless Helpers.is_logged_in?(session)
        
        Helpers.load_songs(session)
        flash[:setup_refresh] = "Refreshed!"

        redirect to '/setup'
    end

    # READ


    # UPDATE


    # DELETE

end