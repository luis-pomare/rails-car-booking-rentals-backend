# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'Api::V1::Cars', type: :request do
  path '/Api/v1/car/{id}' do
    get 'Retrieves a car by ID' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     description: { type: [:string, :null] },
                     cost_per_day: { type: :number },
                     image: { type: [:string, :null] },
                     created_at: { type: :string, format: :date_time },
                     updated_at: { type: :string, format: :date_time }
                   },
                   required: ['id', 'name', 'cost_per_day', 'created_at', 'updated_at']
                 }
               },
               required: ['status', 'message', 'data']

        let(:car) { Car.create(name: 'Test Car', cost_per_day: 100, description: 'Test Description', image: 'Test Image') }
        let(:id) { car.id }

        run_test! do
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('SUCCESS')
          expect(body['message']).to eq('Loaded car')
          expect(body['data']).to be_present
          expect(body['data']['id']).to eq(car.id)
          expect(body['data']['name']).to eq(car.name)
          expect(body['data']['description']).to eq(car.description)
          expect(body['data']['cost_per_day']).to eq(car.cost_per_day.to_f)
          expect(body['data']['image']).to eq(car.image)
          expect(body['data']['created_at']).to be_present
          expect(body['data']['updated_at']).to be_present
        end
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string }
               },
               required: ['status', 'message']

        let(:id) { -1 } # Invalid ID to trigger the ActiveRecord::RecordNotFound

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('ERROR')
          expect(body['message']).to eq('Car does not exist')
        end
      end
    end
  end
end
