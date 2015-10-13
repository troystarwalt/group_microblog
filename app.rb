require 'bundler/setup'
require 'rack-flash'
require 'active_record'
require 'sinatra'
require 'sinatra/activerecord'

require './models.rb'

enable :sessions
use Rack::Flash, :sweep => true
set :bind, "0.0.0.0"
set :sessions, true