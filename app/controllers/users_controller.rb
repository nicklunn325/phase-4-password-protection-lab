class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        # byebug
        if user.id 
            session[:user_id] = user.id 
            render json: user
        else
            render json: {error: "Invalid username and password combination"}, status: 422
        end
    end

    def show
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user
        else
            render json: {error: "Unauthorized"}, status: :unauthorized
        end
    end

    private
    
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
