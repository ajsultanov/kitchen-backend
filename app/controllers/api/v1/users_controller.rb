class Api::V1::UsersController < ApplicationController

    def index 
        @users = User.all
        render json: @users
    end

    def create(user_params)
        @user = User.create(user_params)
        if @user.valid?
            render json: @user, status: :accepted
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:id, :name, :password)
    end
end
