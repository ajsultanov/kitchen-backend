class Spoon
    include RestClient
    @url = "https://api.spoonacular.com/"
    @api_key = ENV["spoon_key"]

    def search(query)
        response = RestClient.get "https://api.spoonacular.com/recipes/search", params: {query: query, apiKey: ENV["spoon_key"]}
        response
    end

    def recipeInfo(id)
        response = RestClient.get "https://api.spoonacular.com/recipes/#{id}/information", params: {apiKey: ENV["spoon_key"]}
        response
    end
end