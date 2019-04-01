require_relative './dbconnect'

class Peep

  def self.show
    res = DbConnect.query("SELECT * FROM peeps;")
  end

  def self.create(content:)
    res = DbConnect.query("INSERT INTO peeps (content) VALUES (#{content}) ;")
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end
end
