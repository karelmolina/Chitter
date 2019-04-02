require 'pg'

p "Setting up test database.."

conection = PG.connect(dbname: ENV["TEST_DATABASE"])

conection.exec("TRUNCATE peeps;")
