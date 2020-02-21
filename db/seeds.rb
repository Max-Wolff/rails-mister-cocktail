# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredient_array = []

ingredients["drinks"].each do |ingredient_hash|
  ingredient_name = ingredient_hash.values[0]
  ingredient_array << ingredient_name
end

ingredient_array = array.sort

ingredient_array.each do |ingredient|
  Ingredient.create(name: ingredient)
end

Cocktail.create(name: "Vodka Sour", picture_url: "https://recipecontent.fooby.ch/13463_3-2_480-320.jpg")
Cocktail.create(name: "Vodka Mate", picture_url: "https://i.pinimg.com/originals/94/db/f2/94dbf2f227cc9a1af31ef0e4d0337a6b.jpg")
Cocktail.create(name: "Jägermeister Shots", picture_url: "https://media-cdn.tripadvisor.com/media/photo-s/0d/8f/65/0e/jaegermeister-germany.jpg")
Cocktail.create(name: "Gin Gin Mule", picture_url: "https://cocktailbart.de/wp-content/uploads/2015/11/Fotolia_83278019_Subscription_Monthly_M.jpg")
Cocktail.create(name: "2410190-berliner-luft-1", picture_url: "https://www.baselweine.ch/img_artikel/large/2410190-berliner-luft-1.jpg")
