require 'bundler/setup'
require 'sinatra/flash'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')
require_relative './lib/peep'
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
    erb :index
  end

  post '/peep' do
    Peep.create(content: params["content"])
    redirect('/')
  end
end
