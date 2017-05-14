class Api::V1::TasksController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!

  def show
    respond_with Task.find_by(id: params[:id])
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: 201, location: [:api, task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task.update(task_params)
      render json: task, status: 201, location: [:api, task]
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    head 204
  end

  def task_params
    params.require(:task).permit(:title, :priority, :description, :list_id)
  end

end
