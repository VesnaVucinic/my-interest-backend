class Api::V1::SessionsController < ApplicationController
    def create
      # byebug
        user = User.find_by(email: params[:session][:email])
    
        if user && user.authenticate(params[:session][:password])
          payload = {user_id: user.id}
          token = encode_token(payload)
          render json: { user: UserSerializer.new(user), jwt: token }, status: :ok
        else
          render json: {
            error: "Invalid Credentials"
        end
    end
    
    # #  need this method becouse in react when I refreshe page I'm loosing data
    # def get_current_user
    #     if logged_in?
    #       render json: UserSerializer.new(@current_user)
    #     else
    #       render json: {
    #         error: "No one logged in"
    #       }
    #     end
    # end


    
    # def destroy
    #     session.clear
    #     render json: {
    #       notice: "successfully logged out"
    #     }, status: :ok
    # end 
    def auto_login
      if session_user
          render json: session_user
      else
          render json: {errors: "No User Logged In."}
      end     
    end
    
end
