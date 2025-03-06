# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'json'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.parse(url).read
movies = JSON.parse(movies_serialized)['results']
img_base = 'https://image.tmdb.org/t/p/w500'

puts 'Cleaning DB...'
Movie.destroy_all

puts 'Creating movies...'
movies.first(10).each do |movie|
  movie = {
    title: movie['title'],
    overview: movie['overview'],
    poster_url: img_base + movie['poster_path'],
    rating: movie['vote_average'].round(1)
  }
  Movie.create(movie)
end

puts "Finished! Created #{Movie.count} movies."
