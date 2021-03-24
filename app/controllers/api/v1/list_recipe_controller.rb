class Api::V1::ListRecipeController < ApplicationController

    def index
        @listrecs = ListRecipe.all
        render json: @listrecs
    end
end
