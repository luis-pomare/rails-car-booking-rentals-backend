# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'Api::V1::Cars', type: :request do
  path '/api/v1/cars' do
    post 'Creates a new car' do
      tags 'Cars'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: [:string, :null] },
          cost_per_day: { type: :number },
          image: { type: [:string, :null] }
        },
        required: ['name', 'cost_per_day']
      }

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

        let(:params) { { name: 'Test Car', cost_per_day: 100 } }

        run_test! do
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('SUCCESS')
          expect(body['message']).to eq('Saved car')
          expect(body['data']).to be_present
          expect(body['data']['id']).to be_present
          expect(body['data']['name']).to eq('Test Car')
          expect(body['data']['description']).to be_nil
          expect(body['data']['cost_per_day']).to eq(100)
          expect(body['data']['image']).to be_nil
          expect(body['data']['created_at']).to be_present
          expect(body['data']['updated_at']).to be_present
        end
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 status: { type: :string },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     name: { type: :array, items: { type: :string } },
                     cost_per_day: { type: :array, items: { type: :string } },
                     description: { type: :array, items: { type: :string } },
                     image: { type: :array, items: { type: :string } }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:params) { { name: '', cost_per_day: 'invalid' } }

        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('ERROR')
          expect(body['message']).to eq('car not saved')
          expect(body['data']).to be_present
          expect(body['data']['name']).to include("can't be blank")
          expect(body['data']['cost_per_day']).to include('is not a number')
          expect(body['data']['description']).to be_nil
          expect(body['data']['image']).to be_nil
        end
      end
    end
  end
end
