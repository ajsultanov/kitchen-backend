class Api::V1::UsersController < ApplicationController
    # skip_before_action :authorized, only: :create
    before_action :find_user, only: [:show, :update]

    def index 
        @users = User.all
        render json: @users
    end

    def show
        render json: @user, status: 200
    end

    def profile
        render json: { user: Api::V1::UserSerializer.new(current_user) }, status: :accepted
    end

    def create
        if User.find_by(name: user_params[:name])
            render json: { message: 'Username already exists' }, status: :unprocessable_entity
            return
        end

        @user = User.create(user_params)
        @serializer = Api::V1::UserSerializer.new(@user)
        if @user.valid?
            token = encode_token(user_id: @user.id)
            # render json: @user, status: :accepted
            render json: { user: @serializer, jwt: token }, status: :created
        else
            render json: { message: 'Error creating user' }, status: :unprocessable_entity
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
