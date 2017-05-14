class Api::V1::SessionsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:show, :destroy]

  def show
    @user = @current_user
    render :template =>'/api/v1/sessions/show.json.jbuilder', :status => 200, :formats => [:json]
  end

  def create
    user_password = params[:password]
    user_email = params[:email]
    @user = user_email.present? && User.find_by(email: user_email)

    if @user.valid_password? user_password
      sign_in @user, store: false
      @user.generate_authentication_token!
      @user.save
      render :template =>'/api/v1/sessions/create.json.jbuilder', :status => 200, :formats => [:json]
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
