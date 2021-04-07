class Api::V1::ListsController < ApplicationController

    def index
        @lists = List.all
        render json: @lists
    end

    def show
        @list = List.find(params[:id])
        render json: @list, status: 200
    end

    def create
        @list = List.create(list_params)
        if @list.valid?
            render json: @list, status: 200
        else
            render json: { message: 'Error creating list' }, status: :unprocessable_entity
        end
    end

    private

    def list_params
        params.require(:list).permit(:name, :description, :user_id)
    end
end
