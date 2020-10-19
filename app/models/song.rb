class Song < ActiveRecord::Base
    belongs_to :album
    has_many :song_users
    has_many :users, through: :song_users
    has_many :song_artists
    has_many :artists, through: :song_artists
end