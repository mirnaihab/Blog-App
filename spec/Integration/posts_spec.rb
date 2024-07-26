require 'swagger_helper'

RSpec.describe 'posts API', type: :request do
  path '/posts' do
    get 'get posts' do
      tags 'Posts'
      produces 'application/json'
      security [ bearer: [] ]

      response '200', 'posts found' do
        let(:Authorization) { authenticated_header }

        run_test! do
          expect(response).to have_http_status(200)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end

      response '404', 'posts not found' do
        let(:Authorization) { authenticated_header }
        run_test!
      end
    end
  end
end
