class Api::V1::AuthController < ApplicationController
    # skip_before_action :authorized, only: :create

    def create
        @user = User.find_by(name: user_login_params[:name])

        # User#authenticate comes from BCrypt
        if @user && @user.authenticate(user_login_params[:password])

            # encode_token comes from ApplicationController
            token = encode_token({ user_id: @user.id })
            render json: { user: @user, jwt: token }, status: :accepted
        else
            render json: { message: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def auto_login
        # current_user comes from ApplicationController
        if current_user
            render json: current_user
        else
            render json: {message: 'Unable to decode token'}, status: :payment_required
        end
    end
     
    private
     
    def user_login_params
        # params { user: {username: 'Handsome Dave', password: 'hi' } }
        params.require(:user).permit(:name, :password)
    end   
end
