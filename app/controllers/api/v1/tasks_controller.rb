class Api::V1::TasksController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!

  def show
    @task = Task.find_by(id: params[:id])
    render :template =>'/api/v1/tasks/show.json.jbuilder', :status => 200, :formats => [:json]
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render :template =>'/api/v1/tasks/create.json.jbuilder', :status => 200, :formats => [:json]
    else
      print(@task.errors)
      render json: { errors: @task.errors }, status: 422
    end
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      render :template =>'/api/v1/tasks/update.json.jbuilder', :status => 200, :formats => [:json]
    else
      print(@task.errors)
      render json: { errors: @task.errors }, status: 422
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    head 204
  end

  def task_params
    require 'date'

    if params.has_key? :deadline
       params[:deadline] = Time.at(params[:deadline]).to_datetime
    end

    params.permit(:title, :priority, :description, :list_id, :deadline, :done)
  end

end
