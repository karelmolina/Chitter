require_relative './dbconnect'

class Peep

  def self.show
    res = DbConnect.query("SELECT * FROM peeps ORDER BY datetime DESC;")
    res.map do |peep|
      Peep.new(id: peep["id"],
              content: peep["content"],
              date: peep["datetime"])
    end

  end

  def self.create(content:)
    res = DbConnect.query("INSERT INTO peeps (content) VALUES ('#{content}') RETURNING id, content, datetime;")
    Peep.new(id: res[0]["id"],
            content: res[0]["content"],
            date: res[0]["datetime"])
  end

  attr_reader :id, :content, :date

  def initialize(id:, content:, date:)
    @id = id
    @content = content
    @date = date
  end
end
