require_relative("../db/sql_runner")
require_relative("movie")
require_relative("star")

class Casting

attr_reader :id, :star_id, :movie_id
attr_accessor :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @star_id = options['star_id'].to_i
    @movie_id = options['movie_id'].to_i
    @fee = options['fee'].to_i
  end

  def save
    sql = "INSERT INTO castings (star_id, movie_id, fee)
           values ($1, $2, $3) RETURNING id"
    values = [@star_id, @movie_id, @fee]
    casting = SqlRunner.run(sql,values).first
    @id = casting['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM castings"
    casting = SqlRunner.run(sql)
    results = castings.map{ |casting| Casting.new(casting) }
    return results
  end

  def budget_update
    sql = "SELECT (SELECT budget FROM movies WHERE id = $1) - (SELECT fee FROM castings WHERE id = $2)"
    values = [@movie_id, @id]
    remaining_budget = SqlRunner.run(sql,values).first
    return remaining_budget
  end

end
