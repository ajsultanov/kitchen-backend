class Api::V1::ListsController < ApplicationController

    def index
        @lists = List.all
        render json: @lists
    end

    def show
        @list = List.find(params[:id])
        @recipes = @list.recipes
        render json: @list, @recipes, status: 200
    end
end
