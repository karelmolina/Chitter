require_relative './dbconnect'
require 'bcrypt'

class User

  def self.create(name:, email:, pass:)
    paasw = BCrypt::Password.create(pass)
    res = DbConnect.query("INSERT INTO users(username,email,password) VALUES('#{name}', '#{email}', '#{passw}') RETURNING id, username, email, password;")
    User.new(id: res[0]['id'],
            name: res[0]['username'],
            email: res[0]['email'],
            pass: res[0]['password'])
  end

  def self.check(name, email)
    res = DbConnect.query("SELECT * FROM users WHERE username = '#{name}' OR email = '#{email}';")
    if res
      return true
    else
      return false
    end
  end

  def self.authenticate(username:, email:, pass:)
    res = DbConnect.query("SELECT * FROM users WHERE username = '#{username}' OR email = #{email}")
    return unless res.any?
    return unless BCrypt::Password.new(res[0]['password']) == pass
    User.new(id: res[0]['id'],
            name: res[0]['username'],
            email: res[0]['email'],
            pass: res[0]['password'])
  end

  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @name = name
    @email = email
  end
end
