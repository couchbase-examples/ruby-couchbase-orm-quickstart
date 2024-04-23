require 'rails_helper'

RSpec.describe 'Airports API', type: :request do
  describe 'GET /api/v1/airports/{id}' do
    let(:airport_id) { 'airport_1262' }

    context 'when the airport exists' do
      let(:expected_airport) do
        {
          'airportname' => 'La Garenne',
          'city' => 'Agen',
          'country' => 'France',
          'faa' => 'AGF',
          'icao' => 'LFBA',
          'tz' => 'Europe/Paris',
          'geo' => {
            'lat' => 44.174721,
            'lon' => 0.590556,
            'alt' => 204
          }
        }
      end

      it 'returns the airport' do
        get "/api/v1/airports/#{airport_id}"

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(expected_airport)
      end
    end

    context 'when the airport does not exist' do
      it 'returns a not found error' do
        get '/api/v1/airports/invalid_id'

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Airport not found' })
      end
    end
  end

  describe 'POST /api/v1/airports/{id}' do
    let(:airport_id) { 'airport_post' }
    let(:airport_params) do
      {
        'airportname' => 'Test Airport',
        'city' => 'Test City',
        'country' => 'Test Country',
        'faa' => '',
        'icao' => 'Test LFAG',
        'tz' => 'Test Europe/Paris',
        'geo' => {
          'lat' => 49.868547,
          'lon' => 3.029578,
          'alt' => 295.0
        }
      }
    end

    context 'when the airport is created successfully' do
      it 'returns the created airport' do
        post "/api/v1/airports/#{airport_id}", params: { airport: airport_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(airport_params)
      rescue StandardError => e
        puts e
      ensure
        delete "/api/v1/airports/#{airport_id}"
      end
    end

    context 'when the airport already exists' do
      let(:airport_id) { 'airport_1262' }
      it 'returns a conflict error' do
        post "/api/v1/airports/#{airport_id}", params: { airport: airport_params }

        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)).to include({ 'message' => "Airport with ID #{airport_id} already exists" })
      end
    end
  end

  describe 'PUT /api/v1/airports/{id}' do
    let(:airport_id) { 'airport_put' }
    let(:current_params) do
      {
        'airportname' => 'Test Airport',
        'city' => 'Test City',
        'country' => 'Test Country',
        'faa' => 'BCD',
        'icao' => 'TEST',
        'tz' => 'Test Europe/Paris',
        'geo' => {
          'lat' => 49.868547,
          'lon' => 3.029578,
          'alt' => 295.0
        }
      }
    end
    let(:updated_params) do
      {
        'airportname' => 'Updated Airport',
        'city' => 'Updated City',
        'country' => 'Updated Country',
        'faa' => 'UPD',
        'icao' => 'UPDT',
        'tz' => 'Updated Europe/Paris',
        'geo' => {
          'lat' => 50.868547,
          'lon' => 4.029578,
          'alt' => 300.0
        }
      }
    end

    context 'when the airport is updated successfully' do
      it 'returns the updated airport' do
        put "/api/v1/airports/#{airport_id}", params: { airport: updated_params }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(updated_params)
      rescue StandardError => e
        puts e
      ensure
        puts "Deleting airport with ID #{airport_id}"
        delete "/api/v1/airports/#{airport_id}"
      end
    end

    context 'when the airport is not updated successfully' do
      it 'returns a bad request error' do
        post "/api/v1/airports/#{airport_id}", params: { airport: current_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(current_params)

        put "/api/v1/airports/#{airport_id}", params: { airport: { airportname: '' } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include({ 'error' => 'Invalid request',
                                                       'message' => 'Missing fields: city, country, faa, icao, tz, geo' })
      rescue StandardError => e
        puts e
      ensure
        delete "/api/v1/airports/#{airport_id}"
      end
    end
  end

  describe 'DELETE /api/v1/airports/{id}' do
    let(:airport_id) { 'airport_delete' }
    let(:airport_params) do
      {
        'airportname' => 'Test Airport',
        'city' => 'Test City',
        'country' => 'Test Country',
        'faa' => 'BCD',
        'icao' => 'TEST',
        'tz' => 'Test Europe/Paris',
        'geo' => {
          'lat' => 49.868547,
          'lon' => 3.029578,
          'alt' => 295.0
        }
      }
    end

    context 'when the airport is deleted successfully' do
      it 'returns a success message' do
        post "/api/v1/airports/#{airport_id}", params: { airport: airport_params }
        expect(response).to have_http_status(:created)

        delete "/api/v1/airports/#{airport_id}"
        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Airport deleted successfully' })
      end
    end

    context 'when the airport does not exist' do
      it 'returns a not found error' do
        delete "/api/v1/airports/#{airport_id}"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Airport not found' })
      end
    end
  end
  describe 'GET /api/v1/airports/direct-connections' do
    let(:destination_airport_code) { 'JFK' }
    let(:limit) { 10 }
    let(:offset) { 0 }
    let(:expected_connections) { %w[DEL LHR EZE ATL CUN MEX LAX SAN SEA SFO] }

    context 'when the destination airport code is provided' do
      it 'returns the direct connections' do
        get '/api/v1/airports/direct-connections',
            params: { destinationAirportCode: destination_airport_code, limit: limit, offset: offset }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(expected_connections)
      end
    end

    context 'when the destination airport code is not provided' do
      it 'returns a bad request error' do
        get '/api/v1/airports/direct-connections'

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Destination airport code is required' })
      end
    end
  end
end
