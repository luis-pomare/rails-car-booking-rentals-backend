# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'Api::V1::Reservations', type: :request do
  path '/Api/v1/users/{user_username}/reservations' do
    get 'Retrieves all reservations for a user' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :user_username, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       user_id: { type: :integer },
                       car_id: { type: :integer },
                       starting_date: { type: :string, format: :date },
                       end_date: { type: :string, format: :date },
                       created_at: { type: :string, format: :date_time },
                       updated_at: { type: :string, format: :date_time }
                     },
                     required: ['id', 'user_id', 'car_id', 'starting_date', 'end_date', 'created_at', 'updated_at']
                   }
                 }
               },
               required: ['status', 'message', 'data']
        User.destroy_all
        Car.destroy_all
        Reservation.destroy_all
        let!(:user) { User.create(username: 'test', full_name: 'test full name') }
        let(:car) { Car.create(name: 'Test Car', cost_per_day: 100, description: 'Test Description', image: 'Test Image') }
        let!(:reservations1) { Reservation.create(user_id: user.id, car_id: car.id, starting_date: Date.today, end_date: Date.today + 1) }
        let!(:reservations2) { Reservation.create(user_id: user.id, car_id: car.id, starting_date: Date.today + 2, end_date: Date.today + 3) }
        let!(:reservations3) { Reservation.create(user_id: user.id, car_id: car.id, starting_date: Date.today + 4, end_date: Date.today + 5)}
        let(:user_username) { user.username }

        run_test! do
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('SUCCESS')
          expect(body['message']).to eq('Loaded all reservations')
          expect(body['data']).to be_present
          expect(body['data'].size).to eq(3)
          body['data'].each do |reservation_data|
            expect(reservation_data['user_id']).to eq(user.id)
            expect(reservation_data['car_id']).to eq(car.id)
            expect(reservation_data['starting_date']).to eq(reservation_data['starting_date'])
            expect(reservation_data['end_date']).to eq(reservation_data['end_date'])
            expect(reservation_data['created_at']).to be_present
            expect(reservation_data['updated_at']).to be_present
          end
        end
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: { type: :null }
               },
               required: ['status', 'message']

        let(:user_username) { 'nothing' } # A non-existent user ID

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('ERROR')
          expect(body['message']).to eq('This user dont have reservations')
          expect(body['data']).to be_nil
        end
      end
    end
  end
end
