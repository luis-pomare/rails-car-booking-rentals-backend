class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.includes(:car).where(user: User.find(params[:user_id]))
    if reservations.nil?
      render json: { status: 'ERROR', message: 'This user dont have reservations' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded all reservations', data: reservations }, status: :ok
    end
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.user = User.find(params[:user_id])
    reservation.car = Car.find(params[:car_id])
    if reservation.save
      render json: { status: 'SUCCESS', message: 'Reservation saved', data: reservation }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Reservation not saved', data: reservation.errors }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(:starting_date, :end_date, :city, :cost)
  end
end
