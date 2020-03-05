require_relative("../db/sql_runner")

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save
    sql = "INSERT INTO stars (first_name, last_name)
           values ($1, $2) RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def update
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def movies
    sql = "SELECT stars.* FROM stars
           INNER JOIN castings ON castings.star_id = star_id WHERE movie_id = $1"
           values = [@id]
           stars = SqlRunner.run(sql, values)
           results = stars.map{ |star| Star.new(star)}
           return results
  end

  def self.delete_all
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    result = stars.map{ |star| Star.new(star)}
    return result
  end



end
