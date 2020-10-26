require_relative './config/environment'
require 'sinatra/activerecord/rake'

namespace :generate do
  desc 'generate a secure session secret'
  task :session_secret do
    puts SecureRandom.hex(64)
  end
end

task :console do
  Pry.start
end
