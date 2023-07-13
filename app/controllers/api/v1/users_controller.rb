class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 'SUCCESS', message: 'Saved user', data: user}, status: :ok
    else
      render json: {status: 'ERROR', message: 'User not saved', data: user.errors}, status: :unprocessable_entity
    end
  end

  def show
    user = User.where(username: params[:username]).first
    if User
      render json: {status: 'SUCCESS', message: 'Loaded user', data: user}, status: :ok
    else
      render json: {status: 'ERROR', message: 'User not found', data: user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.where(username: params[:username]).first
    if user.destroy
      render json: {status: 'SUCCESS', message: 'Deleted user', data: user}, status: :ok
    else
      render json: {status: 'ERROR', message: 'User not deleted', data: user.errors}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :full_name)
  end
end