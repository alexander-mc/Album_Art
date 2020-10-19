class Artist < ActiveRecord::Base
    has_many :song_artists
    has_many :songs, through: :song_artists

    has_many :users, through: :songs
    has_many :albums, through: :songs
end