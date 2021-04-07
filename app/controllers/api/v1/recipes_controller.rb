class Api::V1::RecipesController < ApplicationController

    def index 
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe, status: 200
    end

    def create
        puts params
        if Recipe.find_by(name: recipe_params[:name])
            render json: { message: 'Recipe name already exists' }, status: :unprocessable_entity
            return
        end

        @recipe = Recipe.new(recipe_params)
        if @recipe.valid?
            @recipe.save
            @lr = ListRecipe.create(recipe_id: @recipe.id, list_id: params[:list_id])
            render json: {recipe: @recipe, lr: @lr, message: 'Recipe created!'}, status: :created
        else
            render json: { message: 'Error creating creating' }, status: :unprocessable_entity
        end

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
                url: r["sourceUrl"]
            }
        }
        totalResults = json["totalResults"]

        render json: { results: @results, total: totalResults }, status: 200
    end

    private

    def recipe_params
        params.require(:recipe).permit(
            :name, 
            :author, 
            :cook_time, 
            :servings, 
            :url,
            ingredients: [], 
            steps: []
        )
    end
end