class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: :create
    before_action :find_user, only: [:show, :update]

    def index 
        @users = User.all
        render json: @users
    end

    def show
        render json: @user, status: 200
    end

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token(user_id: @user.id)
            # render json: @user, status: :accepted
            render json: { user: UserSerializer.new(@user), jwt: token }, status: :created
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
