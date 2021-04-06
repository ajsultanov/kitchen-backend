# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "ad", password: "ad")

until User.all.count >= 10 
    User.create(name: Faker::Name.unique.first_name + " " + Faker::Name.unique.last_name, password: "banana")
end 

5.times {
    food = Faker::Food.unique.dish
    List.create(
        name: "#{food} Recipes", 
        description: "Recipes on the theme of #{food}",
        user_id: 1
    )
}

until List.all.count >= 10
    food = Faker::Food.unique.dish
    prng = Random.new
    List.create(
        name: "#{food} Recipes", 
        description: "Recipes on the theme of #{food}",
        user_id: prng.rand(1..10)
    )
end

until Recipe.all.count >= 10
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

5.times { |i|
    ListRecipe.create(
        list_id: 1,
        recipe_id: i
    )
}

until ListRecipe.all.count >= 20
    prng = Random.new
    ListRecipe.create(
        list_id: prng.rand(1..10),
        recipe_id: prng.rand(1..10)
    )
end



# response = RestClient.get 'https://api.spoonacular.com/recipes/search', params: {query: 'pasta', number: '1', includeInstruction: 'true', apiKey: ENV["spoon_key"]}
# response = RestClient.get 'https://api.spoonacular.com/recipes/716429/information', params: {includeNutrition: 'false', apiKey: ENV["spoon_key"]}
# puts response.headers
# puts response.body