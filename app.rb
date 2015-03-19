require 'pry'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  # it's best to draw from the db here in the controller instead of the index i.e. view
  @meetups = Meetup.order(name: :desc)
  erb :index
end

get "/show/:meetup_id" do
  @meetup = Meetup.find(params["meetup_id"].to_i)
  @users = @meetup.users
  erb :show
end

get "/join/:meetup_id" do
  if signed_in?
    new_membership = Membership.new(user_id: session[:user_id], meetup_id: params["meetup_id"].to_i)
    if new_membership.valid?
      new_membership.save
      flash[:notice] = "You have successfully joined #{new_membership.meetup.name}!"
    else
      flash[:notice] = new_membership.errors.messages[:user][0]
    end
    redirect "/"
  else
    authenticate!
    # IMPROVE BY REDIRECTING TO SAME PLACE. DON'T US AUTHENTICATE!
  end
end

get '/new' do
  authenticate!
  erb :new
end

post "/new" do
  name = params["meetup_name"]
  description = params["meetup_description"]
  location = params["meetup_location"]

  if name.empty? || description.empty? || location.empty?
  # binding.pry
    flash[:notice] = "you must fill out all the fields!"
    redirect '/new'
  else
    new_meetup = Meetup.create(name: name, description: description, location: location )
    flash[:notice] = "#{new_meetup.name} created!"
    redirect "/show/#{new_meetup.id}"
  end
end
get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end


get '/example_protected_page' do
  authenticate!
end
