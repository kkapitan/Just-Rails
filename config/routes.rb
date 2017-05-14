require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create]
      resources :sessions, :only => [:create, :destroy]
      resources :lists, :only => [:create, :show, :index]
      resources :tasks, :only => [:show, :create, :destroy, :update]

      devise_for :users
    end
  end
end
