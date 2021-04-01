class Api::V1::ListRecipeController < ApplicationController

    def index
        @listrecs = ListRecipe.all
        render json: @listrecs
    end

    def show
        @listrec = ListRecipe.find(params[:id])
        render json: @listrec
    end
end
