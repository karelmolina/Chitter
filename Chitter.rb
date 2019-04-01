require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')
require_relative './lib/peep'
require_relative './lib/dbconnect'
require_relative './lib/enviroment_helper'
configure(:development) do
  require 'sinatra/reloader'
  require 'pry'
end

helpers do
  # add your helpers here
end

class Chitter < Sinatra::Base
  # index page
  get '/' do
    @connect = DbConnect.query("Select * from peeps;")
    erb :index
  end
end
