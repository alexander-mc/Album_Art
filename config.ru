require_relative './config/environment'

use Rack::MethodOverride
run ApplicationController
use UsersController
use SetupsController
use AlbumsController
