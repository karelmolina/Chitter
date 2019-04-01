require_relative './dbconnect'

class Peep

  def self.show
    res = DbConnect.query("SELECT * FROM peeps;")
    res.map do |peep|
      Peep.new(id: peep["id"],
              content: peep["content"])
    end

  end

  def self.create(content:)
    res = DbConnect.query("INSERT INTO peeps (content) VALUES ('#{content}') RETURNING id, content;")
    Peep.new(id: res[0]["id"],
            content: res[0]["content"])
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end
end
