class User < ActiveRecord::Base
    has_many :song_users
    has_many :songs, through: :song_users
    has_many :artists, through: :songs
    has_many :albums, through: :songs
    has_one  :setup
    
    validates :username,
               presence: { message: "was not entered" },
               format: { with: /\A[a-zA-Z0-9]*\z/, message: "can only contain letters and numbers" },
               uniqueness: { case_sensitive: false, message: "is already taken" }
             
    has_secure_password (options = { validations: false })
              
    validates :password,
               presence: { message: "was not entered" },
               length: { minimum: 6, message: "must contain more than 6 characters"},
               format: { without: /\s/, message: "cannot include spaces"},
               confirmation: { message: "does not match password" }

    scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }
end