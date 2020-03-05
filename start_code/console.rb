require_relative("models/star")
require_relative("models/movie")
require_relative("models/casting")
require('pry')

Casting.delete_all
Movie.delete_all
Star.delete_all

star1 = Star.new({ 'first_name' => 'Arnold', 'last_name' => 'Schwarznegger'})
star2 = Star.new({ 'first_name' => 'Ian', 'last_name' => 'Mckellen'})
star3 = Star.new({ 'first_name' => 'Elijah', 'last_name' => 'Wood'})

movie1 = Movie.new({'title' => 'Terminator', 'genre' => 'action', 'budget' => 400})
movie2 = Movie.new({'title' => 'The Lord Of The Rings', 'genre' => 'fantasy', 'budget' => 500})
movie3 = Movie.new({'title' => 'X-Men', 'genre' => 'action', 'budget' => 400})



star1.save
star2.save
star3.save
movie1.save
movie2.save
movie3.save

casting1 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie1.id, 'fee' => 200})
casting2 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie2.id, 'fee' => 300})
casting3 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie3.id, 'fee' => 250})
casting4 = Casting.new({ 'star_id' => star3.id, 'movie_id' => movie2.id, 'fee' => 150})


casting1.save
casting2.save
casting3.save
casting4.save

binding.pry

nil
