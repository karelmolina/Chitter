require 'bundler/setup'
require 'sinatra/flash'
require 'sinatra'
require 'pony'
require File.join(File.dirname(__FILE__), 'environment')
require_relative './lib/peep'
require_relative './lib/peep_user'
require_relative './lib/users'
require_relative './lib/dbconnect'
require_relative './lib/enviroment_helper'
configure(:development) do
  require 'sinatra/reloader'
  require 'pry'
end

# helpers do
#   # add your helpers here
# end

class Chitter < Sinatra::Base
  #enables
  enable :sessions
  register Sinatra::Flash
  # index page
  get '/' do
    @peeps = PeepUser.show
    @sess = User.find(id: session[:user_id])
    @user = session[:username]
    erb :index
  end

  post '/peep' do
    unless params["content"] != ""
      flash[:notice] = "Tell us what your thinking put a peep!"
    else
      @metion = 'example@example.com'
      @mention = User.mention(content: params["content"])
      if @mention != 'example@example.com'
        @user = session[:username]
        email =  @mention
        Pony.mail :to => email,
                  :from => 'no-reply@chitter',
                  :subject => 'Mention in chitter',
                  :body => erb(:email)
      end
      Peep.create(content: params["content"], user: session[:user_id])
      redirect('/')
    end

  end

  get '/register' do
    erb :register
  end

  post '/register/new' do
    res = DbConnect.query("SELECT * FROM users WHERE username = '#{params["username"]}' OR email = '#{params["email"]}';")
    unless res
      flash[:user] = 'Username or email already exist!'
    else
      if params["password"] == params["re-password"]
        user = User.create(name: params["username"], email: params["email"], pass: params['password'])
        session[:user_id] = user.id
        session[:username] = user.name
        redirect('/')
      else
        flash[:user] = 'Passwords not match'
      end
    end
  end

  get '/login' do
    erb :login
  end

  post '/login/new' do
    user = User.authenticate(username: params["user"],email: params["user"],pass: params["password"])
    if user
      session[:user_id] = user.id
      session[:username] = user.name
      redirect('/')
    else
      flash[:login] = 'Username and/or password are incorrect'
    end
  end

  post '/session/destroy' do
    session.clear
    flash[:notice] = 'You have Log out'
    redirect('/')
  end
end
