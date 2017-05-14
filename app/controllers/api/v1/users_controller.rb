class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.generate_authentication_token!
    if @user.save
      list = List.new(title: 'General', user_id: @user.id)
      if list.save
        render :template =>'/api/v1/users/create.json.jbuilder', :status => 201, :formats => [:json]
      else
        render json: { errors: list.errors }, status: 422
      end
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :username)
  end

end
