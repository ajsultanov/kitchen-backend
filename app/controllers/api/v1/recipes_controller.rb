class Api::V1::RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :update, :destroy]

    def index 
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        puts "recipe:" 
        puts @recipe
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

    def update
        @recipe.update(recipe_params)
        render json: @recipe, status: :accepted
    end

    def destroy
        puts "DESTROYIN A RECIPE HERE"
        @recipe.destroy
        render json: { message: "Recipe deleted"}, status: 200
    end

    def search
        spoon = Spoon.new
        response = spoon.search(params[:query])
        json = JSON.parse(response.body)
        results = json["results"].map { |r|
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

        render json: { results: results, total: totalResults }, status: 200
    end

    def get_info
        spoon = Spoon.new
        response = spoon.recipeInfo(params[:id])
        json = JSON.parse(response.body)
        result = {
            name: json["title"],
            description: json["summary"],
            cook_time: json["readyInMinutes"],
            servings: json["servings"],
            url: json["sourceUrl"],
            ingredients: json["extendedIngredients"].map { |i|
                i["original"]
            },
            steps: json["analyzedInstructions"][0]["steps"].map { |s|
                s["step"]
            }
        }

        render json: result, status: 200
    end

    private

    def recipe_params
        params.require(:recipe).permit(
            :name, 
            :description,
            :author, 
            :cook_time, 
            :servings, 
            :url,
            ingredients: [], 
            steps: []
        )
    end

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end
end