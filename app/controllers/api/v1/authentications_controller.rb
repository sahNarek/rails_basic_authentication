module Api
  module V1
    class AuthenticationsController < ApplicationController
      before_action :authenticate_request, only: :logout
      def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          begin
            exp_time = Time.now + 24.hours.to_i
            token = JsonWebToken.encode(user_id: @user.id)
            @user.update_attribute(:logged, true)
            render json: {token: token, exp: exp_time.strftime("%m-%d-%Y %H:%M"),
                          user_id: @user.id,
                          email: @user.email,
                          logged: @user.logged,},
                   status: :ok
          rescue JWT::EncodeError => e
            render json: {message: e.message}, status: :unauthorized
          end
        else
          render json: {message: "Your credentials are wrong"}, status: :unauthorized
        end
      end

      def logout
        @current_user.update_attribute(:logged, false)
        render json: {message: "Logged Out"}
      end

      private

      def login_params
        params.permit(:email, :password)
      end

    end
  end
end

