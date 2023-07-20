# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'Api::V1::Cars', type: :request do
  path '/Api/v1/cars' do
    get 'Retrieves all cars' do
      tags 'Cars'
      produces 'application/json'

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
                       name: { type: :string },
                       description: { type: %i[string null] },
                       cost_per_day: { type: :number },
                       image: { type: %i[string null] },
                       created_at: { type: :string, format: :date_time },
                       updated_at: { type: :string, format: :date_time }
                     },
                     required: %w[id name cost_per_day created_at updated_at]
                   }
                 }
               },
               required: %w[status message data]

        before do
          Car.destroy_all # Remove all cars from the database
          # Create some test cars to be retrieved in the test
          Car.create(name: 'Test Car 1', cost_per_day: 100)
          Car.create(name: 'Test Car 2', cost_per_day: 120)
        end

        run_test! do
          data = JSON.parse(response.body)['data']
          expect(response).to have_http_status(:ok)
          expect(data).to be_an(Array)
          expect(data.length).to eq(2) # Assuming you created two test cars
          Car.destroy_all # Remove all cars from the database
        end
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: { type: :null } # There should be no data in the response for 422
               },
               required: %w[status message]

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('ERROR')
          expect(body['message']).to eq('Cars not found')
          expect(body['data']).to be_nil # There should be no data in the response for 422
        end
      end
    end
  end
end
