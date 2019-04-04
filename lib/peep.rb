require_relative './dbconnect'

class Peep

  def self.show
    res = DbConnect.query("SELECT id,content,datetime::time,users FROM peeps ORDER BY datetime DESC;")
    res.map do |peep|
      Peep.new(id: peep["id"],
              content: peep["content"],
              date: peep["datetime"],
              user: peep["users"])
    end

  end

  def self.create(content:, user:)
    res = DbConnect.query("INSERT INTO peeps (content,users) VALUES ('#{content}') RETURNING id, content, datetime, users;")
    Peep.new(id: res[0]["id"],
            content: res[0]["content"],
            date: res[0]["datetime"],
            user: res[0]["users"])
  end

  attr_reader :id, :content, :date, :user

  def initialize(id:, content:, date:, user:)
    @id = id
    @content = content
    @date = date
    @user = user
  end
end
