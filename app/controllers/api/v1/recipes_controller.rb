class Api::V1::RecipesController < ApplicationController

    def index 
        @recipes = Recipe.all
        render json: @recipes
    end

    def search
        # spoon = Spoon.new
        # spoon.search(params)
    end

end
