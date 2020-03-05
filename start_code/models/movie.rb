require_relative("../db/sql_runner")

class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
  end

  def save
    sql = "INSERT INTO movies (title, genre, budget)
           values ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def update
    sql = "UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def stars
    sql = "SELECT movies.* FROM movies
           INNER JOIN castings ON castings.movie_id = movie_id WHERE star_id = $1"
           values = [@id]
           movies = SqlRunner.run(sql, values)
           results = movies.map{ |movie| Movie.new(movie)}
           return results
  end

  def self.delete_all
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    result = movies.map{ |movie| Movie.new(movie)}
    return result
  end

end
