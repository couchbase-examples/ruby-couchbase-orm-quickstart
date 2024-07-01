# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding an openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Quickstart in Couchbase with Ruby Couchbase ORM',
        version: 'v1.0',
        description: "<html><body><h2>A quickstart API using Ruby on Rails with Couchbase ORM</h2><p>This API provides endpoints for interacting with data stored in Couchbase using Ruby on Rails. The API allows you to perform CRUD operations on resources such as airlines, airports, routes, and more.</p><p>You can use Swagger UI, which provides a visual representation of the API documentation, to interact with the API's endpoints directly through the browser. It provides a clear view of the API including endpoints, HTTP methods, request parameters, and response objects.</p><p><strong>Trying Out the API</strong></p><p>You can try out the API by clicking on the \"Try it out\" button next to the endpoints.</p><ul><li><strong>Parameters:</strong> Swagger UI provides input boxes for you to fill in if an endpoint requires parameters. This could include path parameters, query strings, headers, or the body of a POST/PUT request.</li><li><strong>Execution:</strong> Once you've inputted all the necessary parameters, you can click the \"Execute\" button to make a live API call. Swagger UI will send the request to the API and display the response directly in the documentation. This includes the response code, response headers, and response body.</li></ul><p><strong>Models</strong></p><p>Swagger documents the structure of request and response bodies using models. These models define the expected data structure using JSON schema and are extremely helpful in understanding what data to send and expect.</p><p>For more details on the API, please refer to the official Couchbase documentation.</p></body></html>"
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          Airline: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              name: { type: 'string' },
              iata: { type: 'string' },
              icao: { type: 'string' },
              callsign: { type: 'string' },
              country: { type: 'string' }
            },
            required: %w[id name iata icao callsign country]
          },
          Airport: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              type: { type: 'string' },
              airportname: { type: 'string' },
              city: { type: 'string' },
              country: { type: 'string' },
              faa: { type: 'string' },
              icao: { type: 'string' },
              tz: { type: 'string' },
              geo: {
                type: 'object',
                properties: {
                  alt: { type: 'number' },
                  lat: { type: 'number' },
                  lon: { type: 'number' }
                },
                required: %w[alt lat lon]
              }
            },
            required: %w[id type airportname city country faa icao tz geo]
          },
          Route: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              type: { type: 'string' },
              airline: { type: 'string' },
              airlineid: { type: 'string' },
              sourceairport: { type: 'string' },
              destinationairport: { type: 'string' },
              stops: { type: 'integer' },
              equipment: { type: 'string' },
              schedule: {
                type: 'array',
                items: {
                  type: 'object',
                  properties: {
                    day: { type: 'integer' },
                    flight: { type: 'string' },
                    utc: { type: 'string' }
                  },
                  required: %w[day flight utc]
                }
              },
              distance: { type: 'number' }
            },
            required: %w[id type airline airlineid sourceairport destinationairport stops
                         equipment schedule distance]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
