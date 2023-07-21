# rubocop:disable all
# require 'swagger_helper'

# RSpec.describe 'Api::V1::ReservationsController', type: :request do
#   before :each do
#     @user = User.create(username: 'Test User', full_name: 'Test User')
#     @car = Car.create(name: 'Test Car', cost_per_day: 100)
#     @reservation = Reservation.create(starting_date: '2023-07-20T12:00:00Z', end_date: '2023-07-22T12:00:00Z', user: @user, car: @car)
#     @user_id = @user.id
#     @id = @reservation.id
#   end

#   path "/Api/v1/user/{user_id}/reservation/{id}" do
#     delete 'Deletes a reservation' do
#       tags 'Reservations'
#       produces 'application/json'
#       parameter name: :user_id, in: :path, type: :integer
#       parameter name: :id, in: :path, type: :integer

#       let (:user)  { User.create(username: 'Test User', full_name: 'Test User') }
#       let (:car ) { Car.create(name: 'Test Car', cost_per_day: 100) }
#       let (:reservation) { Reservation.create(starting_date: '2023-07-20T12:00:00Z', end_date: '2023-07-22T12:00:00Z', user: user, car: car) }
#       let (:user_id) { user.id }
#       let (:id) { reservation.id }
#       response '200', 'OK' do
#         let(:user_id) { @user.id }
#         let(:id) { @reservation.id }
#         run_test! do |response|
#           data = JSON.parse(response.body)['data']
#           expect(response).to have_http_status(:ok)
#           expect(data).to include('id', 'starting_date', 'end_date', 'user_id')
#           expect(data['id']).to eq(@reservation.id)
#           expect(data['user_id']).to eq(@user.id)
#         end
#       end

#       response '422', 'Unprocessable Entity' do
#         let(:user_id) { @user.id }
#         let(:id) { 999 } # Use an invalid reservation id

#         run_test! do |response|
#           expect(response).to have_http_status(:unprocessable_entity)
#         end
#       end
#     end
#   end
# end
