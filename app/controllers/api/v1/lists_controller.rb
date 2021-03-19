class Api::V1::ListsController < ApplicationController

    def show
        @list = List.find(params[:id])
        render json: @list, status: 200
    end
end
