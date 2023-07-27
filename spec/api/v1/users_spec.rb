# rubocop:disable all
require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/Api/v1/users/{username}' do
    # You'll want to customize the parameter types...
    parameter name: 'username', in: :path, type: :string, description: 'username'
    
    get('show user') do
      tags 'Users'
      response(200, 'successful') do
        consumes 'application/json'
        produces 'application/json'
        schema type: :object,
        properties: {
          status: { type: :string },
          message: { type: :string },
          data: {
            type: :object,
            properties: {
              id: { type: :integer },
              username: { type: :string },
              full_name: { type: [:string, :null] },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            },
            required: ['id', 'username', 'full_name', 'created_at', 'updated_at']
          }
        },
        required: ['status', 'message', 'data']
        let(:user) { User.create(username: 'test', full_name: 'test full name') }
        let(:username) { user.username }
        
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
    
    delete('delete user') do
      tags 'Users'
      response(200, 'successful') do
        consumes 'application/json'
        produces 'application/json'
        schema type: :object,
        properties: {
          status: { type: :string },
          message: { type: :string },
          data: {
            type: :object,
            properties: {
              id: { type: :integer },
              username: { type: :string },
              full_name: { type: [:string, :null] },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            },
            required: ['id', 'username', 'full_name', 'created_at', 'updated_at']
          }
        },
        required: ['status', 'message', 'data']
        let(:user) { User.create(username: 'test', full_name: 'test full name') }
        let(:username) { user.username }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/Api/v1/users' do
    
    post('create user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          full_name: { type: :string }
        },
        required: ['username', 'full_name']
      }
      let(:user) { { username: 'test', full_name: 'test full name' } }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
