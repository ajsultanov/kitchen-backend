class ApplicationController < ActionController::API
    # before_action :authorized
    # uncomment previous line to enable auth

    def encode_token(payload)
        JWT.encode(payload, ENV['jwt_secret'])
    end

    def decode_token
        token = request.headers['Authorization']
        if token
            begin
                JWT.decode(token, ENV['jwt_secret'], true)[0]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decode_token
            user_id = decode_token['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end