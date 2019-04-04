require_relative './dbconnect'

class PeepUser

  def self.show
    res = DbConnect.query("SELECT p.content, p.datetime::time, u.username, u.email FROM peeps p INNER JOIN users u ON p.users = u.id ORDER BY p.datetime DESC")
    res.map do |peep|
      PeepUser.new(content: peep['content'],
                    date: peep['datetime'],
                    user: peep['username'],
                    email: peep['email'])
    end
  end

  attr_reader :content, :date, :user, :email

  def initialize(content:, date:, user:, email:)
    @content = content
    @date = date
    @user = user
    @email = email
  end
end
