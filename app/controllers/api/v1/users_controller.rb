class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user.generate_authentication_token!
    if user.save
      list = List.new(title: 'General', user_id: user.id)
      if list.save
        render json: user, status: 201, location: [:api, user]
      else
        render json: { errors: list.errors }, status: 422
      end
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

end
