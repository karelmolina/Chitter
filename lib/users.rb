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
  # needed improvemnt
  # the email validates via html form
  def self.is_email?(email)
    mail =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end

  def self.mention(content:)
    res = DbConnect.query("SELECT username from users;")
    res.map do |user|
      usern = "@" + user["username"]
      check = content.include?usern
      if check
        toemail = email(user["username"])
        return toemail
      end
    end
  end

  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end

  private

  def self.email(username)
    res = DbConnect.query("SELECT email FROM users WHERE username = '#{username}';")
    res.map do |user|
      return user['email']
    end
  end

end
