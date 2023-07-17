class Api::V1::CarsController < ApplicationController
  def index
    cars = Car.all
    if cars.nil?
      render json: { status: 'ERROR', message: 'Cars not found' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded all cars', data: cars }, status: :ok
    end
  end
end
