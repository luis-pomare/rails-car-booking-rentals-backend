# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'Api::V1::ReservationsController', type: :request do
  path '/api/v1/users/{:user_username}/reservations' do
    post 'Creates a new reservation' do
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_username, in: :path, type: :string
      parameter name: :car_id, in: :query, type: :integer
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          city: { type: :string },
          cost: { type: :number },
          car_id: { type: :integer },
          user_id: { type: :integer },
          starting_date: { type: :string, format: 'date-time' },
          end_date: { type: :string, format: 'date-time' }
        },
        required: ['starting_date', 'end_date']
      }

      response '200', 'OK' do
        let(:user_username) { User.create(username: 'Test User', full_name: 'test').username }
        let(:car_id) { Car.create(name: 'Test Car', cost_per_day: 100).id }
        let(:reservation) { { starting_date: '2023-07-20T12:00:00Z', end_date: '2023-07-22T12:00:00Z' } }

        run_test! do |response|
          data = JSON.parse(response.body)['data']
          expect(response).to have_http_status(:ok)
          expect(data).to include('id', 'starting_date', 'end_date', 'user_id', 'car_id')
          expect(data['user_id']).to eq(user_id)
          expect(data['car_id']).to eq(car_id)
        end
      end
    end
  end
end

