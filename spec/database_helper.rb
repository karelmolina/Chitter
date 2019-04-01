require_relative '../lib/dbconnect'

def persisted_data(id:, table:)
  DbConnect.query("SELECT * FROM #{table} WHERE id = #{id};")
end
