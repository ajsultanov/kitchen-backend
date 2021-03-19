class Spoon
    include RestClient
    url = 'https://api.spoonacular.com/'
    api_key = ENV["spoon_key"]

    def search(keyword)
        response = RestClient.get "#{url}search/", params: {query: keyword, number: '1', apiKey: api_key}
        response
    end

    def recipeInfo(id)
        response = RestClient.get "#{url}recipes/#{id}/information", params: {apiKey: api_key}
        response
    end
end