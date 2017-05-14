class Api::V1::SessionsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:show, :destroy]

  def show
    respond_with @current_user
  end

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    @current_user.generate_authentication_token!
    @current_user.save
    head 204
  end

end
