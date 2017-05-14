class Api::V1::ListsController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!

  def show
    @list = List.find(params[:id])
    render :template =>'/api/v1/lists/show.json.jbuilder', :status => 200, :formats => [:json]
  end

  def index
    @lists = @current_user.lists
    render :template =>'/api/v1/lists/index.json.jbuilder', :status => 200, :formats => [:json]
  end

  def create
    @list = List.new(list_params)
    @list.user_id = @current_user.id
    if @list.save
      render :template =>'/api/v1/lists/create.json.jbuilder', :status => 201, :formats => [:json]
    else
      render json: { errors: list.errors }, status: 422
    end
  end

  def list_params
    params.permit(:title)
  end

end
