class ApplicationController < ActionController::API
    #before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, ENV["jwt_secret"])
    end

    def decode_token
        auth_header = request.headers['Authorization']
        if auth_header
            puts auth_header

            # [0] = 'Bearer', [1] = <token>
            token = auth_header.split(' ')[1]
            begin
                # [0] = payload, [1] = alg
                JWT.decode(token, ENV["jwt_secret"], true)[0]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decode_token
            puts decode_token[0]
            user_id = decode_token[0]['user_id']
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