# spec/requests/api/v1/cars_spec.rb
require 'swagger_helper'

RSpec.describe 'Api::V1::CarsController', type: :request do
  path '/Api/v1/cars' do
    get 'Retrieves all cars' do
      tags 'Cars'
      produces 'application/json'
      response '200', 'OK' do
        before do
          Car.create(name: 'Test Car 1', cost_per_day: 100)
        end
        run_test! do
          expect(response).to have_http_status(:ok)
          data = JSON.parse(response.body)
          expect(data['status']).to eq('SUCCESS')
          Car.destroy_all
        end
      end
    end
  end
  path '/Api/v1/cars' do
    post 'Creates a new car' do
      context 'with valid parameters' do
        let(:valid_params) { { name: 'Test Car', cost_per_day: 100 } }
        it 'creates a new car' do
          expect do
            post '/Api/v1/cars', params: valid_params
          end.to change(Car, :count).by(1)
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  path '/Api/v1/car/{id}' do
    parameter name: :id, in: :path, type: :integer
    get 'Shows a specific car' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      response '200', 'OK' do
        let(:id) { Car.create(name: 'Test Car', cost_per_day: 100).id }
        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  path '/Api/v1/cars/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Deletes a car' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        let(:id) { Car.create(name: 'Test Car', cost_per_day: 100).id }
        run_test! do
          expect(response).to have_http_status(:ok)
        end
      end
      response '422', 'Unprocessable Entity' do
        let(:id) { 'invalid' }
        run_test! do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
