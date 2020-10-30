class SetupsController < ApplicationController

    # CREATE / READ / UDPATE
    # Create and read views were almost the same, so I've merged the two routes/views

    get '/setup' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        erb :'/setup/index'
    end

    post '/setup' do
        user = Helpers.current_user(session)
        num_songs_needed = params[:rows].to_i * params[:columns].to_i
        
        user.build_setup(params)

        # Validate input
        if !user.setup.valid?
            flash[:setup_error] = user.setup.errors.full_messages
            redirect to '/setup'
        elsif user.songs.count < num_songs_needed
            flash[:setup_error] = Array("This setup requires #{num_songs_needed} songs. Adjust the number of columns/rows or click on 'Refresh' to check if any additional songs can be loaded from Spotify.")
            redirect to '/setup'
        end

        user.setup.save
        redirect to '/albums/edit'
    end

    get '/setup/refresh' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        
        Helpers.load_songs(session)
        flash[:setup_refresh] = "Done!"

        redirect to '/setup'
    end

    # DELETE

end