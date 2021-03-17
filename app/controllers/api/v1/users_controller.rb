class Api::V1::UsersController < ApplicationController
    before_action :find_user, only: [:show, :update]

    def index 
        @users = User.all
        render json: @users
    end

    def show
        render json: @user, status: 200
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: @user, status: :accepted
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :password)
    end

    def find_user
        @user = User.find(params[:id])
    end
end
