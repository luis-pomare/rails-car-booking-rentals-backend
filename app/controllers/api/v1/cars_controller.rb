class Api::V1::CarsController < ApplicationController
  def index
    cars = Car.all
    if cars.empty?
      render json: { status: 'ERROR', message: 'Cars not found' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded all cars', data: cars }, status: :ok
    end
  end

  def create
    car = Car.new(car_params)
    if car.save
      render json: { status: 'SUCCESS', message: 'Saved car', data: car }, status: :ok
    else
      render json: { status: 'ERROR', message: 'car not saved', data: car.errors }, status: :unprocessable_entity
    end
  end

  def show
    car = Car.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded car', data: car }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'ERROR', message: 'Car does not exist' }, status: :unprocessable_entity
  end

  def destroy
    car = Car.find(params[:id])
    car.destroy
    render json: { status: 'SUCCESS', message: 'Car deleted', data: car }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'ERROR', message: 'Car does not exist' }, status: :unprocessable_entity
  end

  private

  def car_params
    params.permit(:name, :description, :cost_per_day, :image)
  end
end
