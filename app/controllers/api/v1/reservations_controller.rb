class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.includes(:car).where(user: User.find_by(username: params[:user_username]))
    unless reservations.nil?
      data = reservations.as_json(include: :car)
      render json: { status: 'SUCCESS', message: 'Loaded all reservations', data: }, status: :ok
    end
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'ERROR', message: 'This user dont have reservations' }, status: :unprocessable_entity
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.user = User.find_by(username: params[:user_username])
    reservation.car = Car.find(params[:car_id])
    if reservation.save
      render json: { status: 'SUCCESS', message: 'Reservation saved', data: reservation }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Reservation not saved', data: reservation.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])

    if reservation.nil?
      return render json: { status: 'ERROR', message: 'Reservation does not exist' }, status: :unprocessable_entity
    end

    if reservation.destroy
      render json: { status: 'SUCCESS', message: 'Deleted reservation', data: reservation }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Reservation not deleted', data: reservation.errors },
             status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(:starting_date, :end_date, :city, :cost)
  end
end
