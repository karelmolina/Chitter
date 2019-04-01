require_relative'./dbconnect'

if ENV['ENVIROMENT'] == 'test'
  DbConnect.setup(ENV["TEST_DATABASE"])
else
  DbConnect.setup(ENV["DATABASE"])
end
