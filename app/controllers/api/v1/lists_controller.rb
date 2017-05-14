class Api::V1::ListsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!

  def show
    respond_with List.find(by: params[:id])
  end

  def index
    lists = List.all.where(user_id: @current_user.id)
    respond_with lists
  end

  def create
    list = List.new(list_params)
    if list.save
      render json: list, status: 201, location: [:api, list]
    else
      render json: { errors: list.errors }, status: 422
    end
  end

  def list_params
    params.require(:list).permit(:title, :user_id)
  end

end
