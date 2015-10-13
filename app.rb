require 'bundler/setup'
require 'rack-flash'
require 'active_record'
require 'sinatra'
require 'sinatra/activerecord'
require 'rerun'

require './models.rb'

enable :sessions
use Rack::Flash, :sweep => true
set :bind, "0.0.0.0"
set :sessions, true

get '/' do 
	@users = User.all
    erb :index
end

get '/signup' do
	erb :signup
end

post "/user_create" do
	if params[:username].empty? ||
		params[:email].empty? ||
		params[:password].empty?
		redirect to("/user_create_error")
	else
		User.create({
			:username => params[:username],
			:email => params[:email],
			:password => params[:password]
		})
		redirect to("/user_create_success")
	end
end

get "/user_create_error" do
	"Please try again."
end

get "/user_create_success" do
	@users = User.all
	redirect to ("/profile")
end

get "/profile" do
	@users = User.find(session[:user_id])
	erb :profile
end