require 'swagger_helper'

describe 'Airports API', type: :request do
  path '/api/v1/airports/{id}' do
    get 'Retrieves an airport by ID' do
      tags 'Airports'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airport'

      response '200', 'airport found' do
        schema type: :object,
               properties: {
                 airportname: { type: :string },
                 city: { type: :string },
                 country: { type: :string },
                 faa: { type: :string },
                 icao: { type: :string },
                 tz: { type: :string },
                 geo: {
                   type: :object,
                   properties: {
                     alt: { type: :number },
                     lat: { type: :number },
                     lon: { type: :number }
                   }
                 }
               },
               required: %w[airportname city country faa icao tz geo]

        let(:id) { 'airport_1262' }
        run_test!
      end

      response '404', 'airport not found' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end

    post 'Creates an airport' do
      tags 'Airports'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airport'
      parameter name: :airport, in: :body, schema: {
        type: :object,
        properties: {
          airportname: { type: :string },
          city: { type: :string },
          country: { type: :string },
          faa: { type: :string },
          icao: { type: :string },
          tz: { type: :string },
          geo: {
            type: :object,
            properties: {
              alt: { type: :number },
              lat: { type: :number },
              lon: { type: :number }
            }
          }
        },
        required: %w[airportname city country faa icao tz geo]
      }

      response '201', 'airport created' do
        let(:airport) do
          {
            airportname: 'Test Airport',
            city: 'Test City',
            country: 'Test Country',
            faa: '',
            icao: 'Test LFAG',
            tz: 'Test Europe/Paris',
            geo: {
              lat: 49.868547,
              lon: 3.029578,
              alt: 295.0
            }
          }
        end
        run_test!
      end

      response '400', 'bad request' do
        let(:airport) do
          {
            airportname: 'Test Airport',
            city: 'Test City',
            country: 'Test Country',
            faa: '',
            icao: 'Test LFAG',
            tz: 'Test Europe/Paris',
            geo: {
              lat: 49.868547,
              lon: 3.029578
            }
          }
        end
        run_test!
      end

      response '409', 'airport already exists' do
        let(:airport) do
          {
            airportname: 'Test Airport',
            city: 'Test City',
            country: 'Test Country',
            faa: '',
            icao: 'Test LFAG',
            tz: 'Test Europe/Paris',
            geo: {
              lat: 49.868547,
              lon: 3.029578,
              alt: 295.0
            }
          }
        end
        run_test!
      end
    end

    put 'Updates an airport' do
      tags 'Airports'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airport'
      parameter name: :airport, in: :body, schema: {
        type: :object,
        properties: {
          airportname: { type: :string },
          city: { type: :string },
          country: { type: :string },
          faa: { type: :string },
          icao: { type: :string },
          tz: { type: :string },
          geo: {
            type: :object,
            properties: {
              alt: { type: :number },
              lat: { type: :number },
              lon: { type: :number }
            }
          }
        }
      }

      response '200', 'airport updated' do
        let(:id) { 'airport_1262' }
        let(:airport) { { airportname: 'Updated Airport' } }
        run_test!
      end

      response '400', 'bad request' do
        let(:id) { 'airport_1262' }
        let(:airport) { { airportname: '' } }
        run_test!
      end
    end

    delete 'Deletes an airport' do
      tags 'Airports'
      parameter name: :id, in: :path, type: :string, description: 'ID of the airport'

      response '204', 'airport deleted' do
        let(:id) { 'airport_1262' }
        run_test!
      end

      response '404', 'airport not found' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end
  end

  path '/api/v1/airports/direct-connections' do
    get 'Retrieves all direct connections from a target airport' do
      tags 'Airports'
      produces 'application/json'
      parameter name: :destinationAirportCode, in: :query, type: :string,
                description: 'FAA code of the target airport', required: true
      parameter name: :limit, in: :query, type: :integer, description: 'Maximum number of results to return'
      parameter name: :offset, in: :query, type: :integer, description: 'Number of results to skip for pagination'

      response '200', 'direct connections found' do
        schema type: :array,
               items: {
                 type: :string
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
