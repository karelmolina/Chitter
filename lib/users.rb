require_relative './dbconnect'
require 'bcrypt'

class User

  def self.create(name:, email:, pass:)
    passw = BCrypt::Password.create(pass)
    res = DbConnect.query("INSERT INTO users(username,email,password) VALUES('#{name}', '#{email}', '#{passw}') RETURNING id, username, email, password;")
    User.new(id: res[0]['id'],
            name: res[0]['username'],
            email: res[0]['email'])
  end

  def self.authenticate(username:, email:, pass:)
    res = DbConnect.query("SELECT * FROM users WHERE username = '#{username}' OR email = '#{email}'")
    return unless res.any?
    return unless BCrypt::Password.new(res[0]['password']) == pass
    User.new(id: res[0]['id'],
            name: res[0]['username'],
            email: res[0]['email'])
  end

  def self.find(id:)
    return nil unless id
    res = DbConnect.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(id: res[0]['id'],
            name: res[0]['username'],
            email: res[0]['email'])
  end

  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end
end
