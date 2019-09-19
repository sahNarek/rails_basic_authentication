module Api
  module V1
    class UsersController < ApplicationController
    before_action :authenticate_request, except: :create

    def show
      if user_logged?
        render json: @current_user
      else
        head(:unauthorized)
      end
    end

    def create
      @user = User.new(user_params)
      begin
        @user.save!
        render json: @user, serializer: UserSerializer
      rescue ActiveRecord::RecordInvalid => e
        render json: {message: e.message}
      end
    end

      private

    def user_logged?
      @current_user.id == params[:id].to_i
    end

    def user_params
      params.permit(:id, :first_name, :last_name,
                    :email, :password, :password_confirmation)
    end

    end
  end
end

