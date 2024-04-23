require 'swagger_helper'

describe 'Airlines API', type: :request do
  path '/api/v1/airlines/{id}' do
    get 'Retrieves an airline by ID' do
      tags 'Airlines'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airline'

      response '200', 'airline found' do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 iata: { type: :string },
                 icao: { type: :string },
                 callsign: { type: :string },
                 country: { type: :string }
               },
               required: %w[name iata icao callsign country]

        let(:id) { 'airline_10' }
        run_test!
      end

      response '404', 'airline not found' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end

    post 'Creates an airline' do
      tags 'Airlines'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airline'
      parameter name: :airline, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          iata: { type: :string },
          icao: { type: :string },
          callsign: { type: :string },
          country: { type: :string }
        },
        required: %w[name iata icao callsign country]
      }

      response '201', 'airline created' do
        let(:airline) { { name: 'Foo Airlines', iata: 'FA', icao: 'FOO', callsign: 'FOO', country: 'US' } }
        run_test!
      end

      response '400', 'bad request' do
        let(:airline) { { name: 'Foo Airlines', iata: 'FA', icao: 'FOO', callsign: 'FOO' } }
        run_test!
      end

      response '409', 'airline already exists' do
        let(:airline) { { name: 'Foo Airlines', iata: 'FA', icao: 'FOO', callsign: 'FOO', country: 'US' } }
        run_test!
      end
    end

    put 'Updates an airline' do
      tags 'Airlines'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airline'
      parameter name: :airline, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          iata: { type: :string },
          icao: { type: :string },
          callsign: { type: :string },
          country: { type: :string }
        }
      }

      response '200', 'airline updated' do
        let(:id) { 'airline_10' }
        let(:airline) { { name: 'Updated Airline' } }
        run_test!
      end

      response '400', 'bad request' do
        let(:id) { 'airline_10' }
        let(:airline) { { name: '' } }
        run_test!
      end
    end

    delete 'Deletes an airline' do
      tags 'Airlines'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airline'

      response '204', 'airline deleted' do
        let(:id) { 'airline_10' }
        run_test!
      end

      response '404', 'airline not found' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end
  end

  path '/api/v1/airlines/list' do
    get 'Retrieves all airlines by country' do
      tags 'Airlines'
      produces 'application/json'
      parameter name: :country, in: :query, type: :string, description: 'Country of the airline'
      parameter name: :limit, in: :query, type: :integer, description: 'Maximum number of results to return'
      parameter name: :offset, in: :query, type: :integer, description: 'Number of results to skip for pagination'

      response '200', 'airlines found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   iata: { type: :string },
                   icao: { type: :string },
                   callsign: { type: :string },
                   country: { type: :string }
                 },
                 required: %w[name iata icao callsign country]
               }

        let(:country) { 'United States' }
        let(:limit) { 10 }
        let(:offset) { 0 }
        run_test!
      end
    end
  end

  path '/api/v1/airlines/to-airport' do
    get 'Retrieves airlines flying to a destination airport' do
      tags 'Airlines'
      produces 'application/json'
      parameter name: :destinationAirportCode, in: :query, type: :string,
                description: 'The ICAO or IATA code of the destination airport'
      parameter name: :limit, in: :query, type: :integer, description: 'Maximum number of results to return'
      parameter name: :offset, in: :query, type: :integer, description: 'Number of results to skip for pagination'

      response '200', 'airlines found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   iata: { type: :string },
                   icao: { type: :string },
                   callsign: { type: :string },
                   country: { type: :string }
                 },
                 required: %w[name iata icao callsign country]
               }

        let(:destinationAirportCode) { 'LAX' }
        let(:limit) { 10 }
        let(:offset) { 0 }
        run_test!
      end

      response '400', 'bad request' do
        let(:destinationAirportCode) { '' }
        run_test!
      end
    end
  end
end
