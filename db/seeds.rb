# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

until User.all.count >= 10 
    User.create(name: Faker::Name.unique.first_name + " " + Faker::Name.unique.last_name, password: "banana")
end 

until List.all.count >= 5
    food = Faker::Food.unique.dish
    prng = Random.new
    List.create(
        name: "#{food} Recipes", 
        description: "Recipes on the theme of #{food}",
        user_id: prng.rand(1..10)
    )
end

until Recipe.all.count >= 5
    food = Faker::Food.unique.dish
    ingredient1 = Faker::Food.unique.ingredient
    ingredient2 = Faker::Food.unique.ingredient
    ingredient3 = Faker::Food.unique.ingredient
    prng = Random.new
    Recipe.create(
        name: food,
        description: Faker::Food.unique.description, 
        author: Faker::Name.unique.name, 
        steps: ["Chop the #{ingredient1.downcase}", "Saute the #{ingredient2.downcase}", "Mix in the #{ingredient3.downcase}", "Serve hot"],
        cook_time: prng.rand(10..90), 
        servings: prng.rand(2..12),
        ingredients: ["1 oz #{ingredient1.downcase}", "2 #{ingredient2.downcase.pluralize(2)}", "1/4 tbsp #{ingredient3.downcase}"],
        url: ""
    )
end

until ListRecipe.all.count >= 10
    prng = Random.new
    ListRecipe.create(
        list_id: prng.rand(1..5),
        recipe_id: prng.rand(1..5)
    )
end

# response = RestClient.get 'https://api.spoonacular.com/recipes/search', params: {query: 'pasta', number: '1', includeInstruction: 'true', apiKey: ENV["spoon_key"]}
# response = RestClient.get 'https://api.spoonacular.com/recipes/716429/information', params: {includeNutrition: 'false', apiKey: ENV["spoon_key"]}
# puts response.headers
# puts response.body