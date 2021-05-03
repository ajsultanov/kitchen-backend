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

    def update
        @list = List.find(params[:id])
        @list.update(list_params)
        render json: { list: @list }, status: :accepted
    end

    def destroy
        @list = List.find(params[:id])
        @list.destroy
        render json: { message: "List deleted"}, status: 200
    end

    private

    def list_params
        params.require(:list).permit(:name, :description, :user_id)
    end
end
