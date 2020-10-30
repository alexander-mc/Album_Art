class Helpers

    def self.current_user(session)
        current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def self.is_logged_in?(session)
        # Logs out users who are logged in but not authenticated
        session.clear if !!current_user(session) && session[:credentials].nil?
        !!current_user(session)
    end

    def self.load_songs(session)
        user = current_user(session)

        RSpotify::User.new(session[:credentials]).recently_played.reverse_each do |s|

            # Find songs if already persisted in database
            song = Song.find_by(title: s.name)

            # Find or create artist & list artist ids new songs
            artist_ids = []
            s.artists.each do |a| 
                artist = Artist.find_or_create_by(name: a.name)
                artist_ids << artist.id 
            end

            # Update or create new song & album
            if song
                user_ids = song.user_ids
                user_ids << user.id unless user_ids.include?(user.id)

                # Remove preview attribute if Spotify preview link is disabled
                song.update(title: s.name, preview_url: s.preview_url, external_url: s.external_urls["spotify"], artist_ids: artist_ids, user_ids: user_ids)
            else
                album = Album.find_or_create_by(title: s.album.name, image: s.album.images[2]['url'])
                
                # Remove preview attribute if Spotify preview link is disabled
                album.songs.build(title: s.name, preview_url: s.preview_url, external_url: s.external_urls["spotify"], artist_ids: artist_ids, user_ids: Array(user.id))
                album.songs.last.save(validate: false)
            end
        end
    end

    def self.set_default_preferred_songs(session)
        user = current_user(session)

        num_songs_needed = user.setup.rows * user.setup.columns
        preferred_song_ids = []

        user.songs.reverse.take(num_songs_needed).each do |s|
            preferred_song_ids << s.id
        end

        user.preferred_songs = preferred_song_ids
        user.save(validate: false)
    end

    def self.set_random_preferred_songs(session)
        user = current_user(session)

        song_ids = user.songs.map{|s| s.id}
        num_songs_needed = user.setup.rows * user.setup.columns

        user.preferred_songs = (song_ids).to_a.shuffle.take(num_songs_needed)
        user.save(validate: false)
    end

    def self.remove_song(song_id, session)
        user = current_user(session)
        
        user.songs.delete(song_id)

        preferred_song_ids = JSON.parse(user.preferred_songs)
        preferred_song_ids.delete(song_id)
        user.preferred_songs = preferred_song_ids
        user.save(validate: false)
    end

    def self.save_preferred_songs(session, preferred_song_ids)
        user = current_user(session)
        user.preferred_songs = preferred_song_ids.map {|s| s.to_i }
        user.save(validate: false)
    end

end