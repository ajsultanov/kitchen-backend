class Api::V1::RecipesController < ApplicationController

    def index 
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe, status: 200
    end

    def search
        spoon = Spoon.new
        response = spoon.search(params[:query])
        puts response
        json = JSON.parse(response.body)
        @results = json["results"].map { |r|
            {
                id: r["id"],
                image: r["image"],
                name: r["title"],
                time: r["readyInMinutes"],
                servings: r["servings"],
                url: r["url"]
            }
        }

        render json: @results, status: 200
    end

end
