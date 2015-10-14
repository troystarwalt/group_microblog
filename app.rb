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

# def current_user
# 	if session[:user_id]
#     User.find.session[:user_id]
#    end
# end

get '/' do 
	@user = User.all
    erb :index
end

get '/signup' do
	erb :signup
end

get '/login' do
	erb :login
end

get '/logout' do
	flash[:notice] = "You'll Be Back."
	session.clear
	redirect to("/")
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

get "/ourthrow" do
	@user = User.all
	@throw = Throw.all
	erb :ourthrow
end

post "/submit_throw" do
	if params[:user_throw].empty?
		redirect to("/user_throw_error")
	else
		Throw.create({
			:throwpost => params[:user_throw], user_id: session[:user_id]
		})
		redirect to("/user_throw_success")
	end
end

get "/user_throw_error" do
	"Sorry try again."
end

get "/user_throw_success" do
	"Woo!"
end

get "/user_create_error" do
	"Please try again."
end

get "/user_create_success" do
	flash[:notice] = "Welcome!"
	@user_current = User.last
	@users = User.all
	erb :user_create_success	
end

get "/profile" do
	@user = User.find(session[:user_id])
	erb :profile
end

get "/login_error" do
	"Sorry Your username or password was not correct."
end


get "/seeusers" do
	@user = User.all
	erb :seeusers
end


delete '/users/:id' do
        session.clear
        current_user.delete
       erb :edit_profile
end





