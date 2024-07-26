require 'swagger_helper'

describe 'Authentication API' do
  path '/auth/login' do
    post 'Logs in a user and returns a JWT token' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'successful' do
        schema type: :object, properties: {
          token: { type: :string }
        }
        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
