class AlbumsController < ApplicationController

    get '/albums' do

        @user = Helpers.current_user(session)

        redirect to '/' unless Helpers.is_logged_in?(session)
        redirect to '/setup' if @user.setup.nil?
        redirect to '/albums/edit' if @user.preferred_songs.nil?
        redirect to '/albums/edit' if JSON.parse(@user.preferred_songs).count != (@user.setup.rows * @user.setup.columns)

        @preferred_songs = @user.songs.where(id: JSON.parse(@user.preferred_songs))

        erb :'/albums/index'
    end

    get '/albums/edit' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        redirect to '/setup' if Helpers.current_user(session).setup.nil?

        @user = Helpers.current_user(session)
        @num_songs_needed = @user.setup.rows * @user.setup.columns

        @user.preferred_songs = [] if @user.preferred_songs.nil?
        @preferred_song_ids = JSON.parse(@user.preferred_songs)

        erb :'/albums/edit'
    end

    patch '/albums' do
        user = Helpers.current_user(session)
        
        # Validate selection
        num_songs_needed = user.setup.rows * user.setup.columns
        params[:preferred_song_ids].nil? ? num_selected_songs = 0 : num_selected_songs = params[:preferred_song_ids].count

        if num_selected_songs != num_songs_needed
            flash[:selection_error] = "You have selected #{num_selected_songs} songs but need #{num_songs_needed} songs."

            if num_selected_songs != 0
                Helpers.save_preferred_songs(session, params[:preferred_song_ids])
            end

            redirect to '/albums/edit'
        end

        Helpers.save_preferred_songs(session, params[:preferred_song_ids])
        redirect to '/albums'
    end

    get '/albums/refresh' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        redirect to '/setup' if Helpers.current_user(session).setup.nil?

        Helpers.load_songs(session)
        # Set default preferred songs -- uncomment to enable
        # Helpers.set_default_preferred_songs(session)
        
        flash[:albums_refresh] = "Refreshed!"
        
        redirect to '/albums/edit'
    end
 
    get '/albums/select/:type' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        redirect to '/setup' if Helpers.current_user(session).setup.nil?       
        
        user = Helpers.current_user(session)

        case params[:type]
            when "first"
                Helpers.set_default_preferred_songs(session)
            when "random"
                Helpers.set_random_preferred_songs(session)
            when "none"
                user.preferred_songs = []
                user.save(validate: false)
        end

        redirect to '/albums/edit'
    end

    get '/albums/:song_id/delete' do
        redirect to '/' unless Helpers.is_logged_in?(session)
        redirect to '/setup' if Helpers.current_user(session).setup.nil?   
        
        Helpers.remove_song(params[:song_id].to_i, session)
        
        redirect to '/albums/edit'
    end
    
end