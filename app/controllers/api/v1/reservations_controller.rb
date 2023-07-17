class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.where(user: User.find(params[:user_id]))
    if reservations.nil?
      render json: { status: 'ERROR', message: 'This user dont have reservations' }, status: :unprocessable_entity
    else
      render json: { status: 'SUCCESS', message: 'Loaded all reservations', data: reservations }, status: :ok
    end
  end
end
