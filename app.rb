require 'bundler/setup'
require 'sinatra/flash'
require 'active_record'
require 'sinatra'
require 'sinatra/activerecord'
require 'rerun'

require './models.rb'

enable :sessions

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

get '/login' do
	erb :login
end

post "/user_login_attempt" do
	# constraints for success
	# 1. username needs to exist in the database
	# 2. password needs to match the username's password

	matching_users = User.all.where({
		:username => params[:username]
	})

	if matching_users.first
		# first way we can pass information to a redirect, by using a query string
		# redirect to("/profile" + "?" + matching_users.first.name)

		# second way we can pass information to a redirect, by using a session
		session[:user_id] = matching_users.first.id
		redirect to("/profile")
	else
		redirect to("/login_error")
	end
end



get "/user_create_error" do
	"Please try again."
end

get "/user_create_success" do
	@users = User.all
	erb :user_create_success
	
end

get "/profile" do
	@users = User.find(session[:user.id])
	erb :profile
end