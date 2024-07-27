# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  Rswag::Specs::SwaggerHelper.configure do |config|
    config.swagger_root = Rails.root.join('swagger').to_s
    config.swagger_dry_run = false
    config.swagger_format = :yaml
  end

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      security: [
        {
          'Bearer': []
        }
      ],
      securityDefinitions: {
        'Bearer': {
          type: 'apiKey',
          name: 'Authorization',
          in: 'header',
          description: 'Bearer token for authentication'
        }
      },
      paths: {},
      components: {
        schemas: {
          Post: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              title: { type: 'string' },
              body: { type: 'string' },
              tags: { type: 'string' }, # Adjust this if tags is an array or another type
              created_at: { type: 'string', format: 'date-time' },
              updated_at: { type: 'string', format: 'date-time' }
            },
            required: [ 'title', 'body' ]
          }
        }
      },
      servers: [
        {
          url: 'http://web:3000'

          # url: 'http://localhost:3000'
        }
      ]
    }
  }

  config.openapi_format = :yaml
end
