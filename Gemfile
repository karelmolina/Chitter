# frozen_string_literal: true
source "https://rubygems.org"

gem 'bcrypt'
gem 'bundler'
gem 'capybara'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-flash'
gem 'erubis'
gem 'rake'
gem 'dotenv'
gem 'pg'
gem 'pony'
gem 'simplecov'
gem 'simplecov-console'

group :production do
  gem "puma"
end

group :development do
  gem 'pry'
  gem 'rubocop'
end

group :test do
  gem 'rspec', :require => 'spec'
  gem 'rack-test'
end
