require 'bundler/setup'
require 'sinatra/flash'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')
require_relative './lib/peep'
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
    @peeps = Peep.show
    @sess = session[:user_id]
    @user = session[:username]
    erb :index
  end

  post '/peep' do
    user = session["user_id"]
    Peep.create(content: params["content"])
    redirect('/')
  end

  get '/register' do
    erb :register
  end

  post '/register/new' do
    username = params['username']
    email = params['email']
    check = User.check(username, email)
    if check
      flash[:user] = 'Username or email already exist!'
    else
      if params["password"] == params["re-password"]
        user = User.create(name: username, emai: email, pass: params['password'])
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
end
