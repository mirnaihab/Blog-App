require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    post 'Registers a new user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John Doe' },
          email: { type: :string, example: 'john@example.com' },
          password: { type: :string, example: 'password123' },
          password_confirmation: { type: :string, example: 'password123' },
          image: { type: :string, example: 'http://example.com/image.png' }
        },
        required: [ 'name', 'email', 'password', 'password_confirmation' ]
      }

      response '201', 'User created' do
        let(:user) { { name: 'John Doe', email: 'john@example.com', password: 'password123', password_confirmation: 'password123', image: 'http://example.com/image.png' } }
        run_test!
      end

      response '422', 'Validation error' do
        let(:user) { { name: 'John Doe', email: 'john@example.com', password: 'password123', password_confirmation: 'differentpassword' } }
        run_test!
      end
    end
  end
end
