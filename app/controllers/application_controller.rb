class ApplicationController < ActionController::API

  def authenticate_request
    header = request.headers["Auth"]
    token = header.present? ? header.split(" ").last : nil
    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find_by id: @decoded[:user_id], logged: true
      render json: {message: "Please Sign in"}, status: :unauthorized if @current_user.nil?
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e.message}, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {message: e.message}, status: :unauthorized
    end
  end

end
