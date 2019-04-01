require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'

ENV['ENVIROMENT'] = 'test'
# bring in the content of app.rb
require File.join(File.dirname(__FILE__), '..', 'Chitter.rb')
#
Dir.glob(File.expand_path('../*.rb', __FILE__)).each do |file|
  require file
end
#set capybara app
Capybara.app = Chitter
# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false



SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
