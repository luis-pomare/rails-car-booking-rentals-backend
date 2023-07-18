class Api::V1::CarsController < ApplicationController
  def index
    cars = Car.all
    if cars.nil?
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
    if car.nil?
      render json: { status: 'ERROR', message: 'Car does not exist' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded car', data: car }, status: :ok
    end
  end

  def destroy
    car = Car.find(params[:id])
    return render json: { status: 'ERROR', message: 'Car does not exist' }, status: :unprocessable_entity if car.nil?

    if car.destroy
      render json: { status: 'SUCCESS', message: 'Deleted car', data: car }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Car not deleted', data: car.errors }, status: :unprocessable_entity
    end
  end

  private

  def car_params
    params.permit(:name, :description, :cost_per_day, :image)
  end
end
