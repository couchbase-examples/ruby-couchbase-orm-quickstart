# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Airlines API', type: :request do
  describe 'GET /api/v1/airlines/{id}' do
    let(:airline_id) { 'airline_10' }
    let(:expected_airline) do
      {
        'name' => '40-Mile Air',
        'iata' => 'Q5',
        'icao' => 'MLA',
        'callsign' => 'MILE-AIR',
        'country' => 'United States'
      }
    end

    it 'returns the airline' do
      get "/api/v1/airlines/#{airline_id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to eq(expected_airline)
    end
  end

  describe 'POST /api/v1/airlines/{id}' do
    let(:airline_id) { 'airline_post' }
    let(:airline_params) do
      {
        'name' => '40-Mile Air',
        'iata' => 'Q5',
        'icao' => 'MLA',
        'callsign' => 'MILE-AIR',
        'country' => 'United States'
      }
    end

    context 'when the airline is created successfully' do
      it 'returns the created airline' do
        post "/api/v1/airlines/#{airline_id}", params: { airline: airline_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(airline_params)
      rescue StandardError => e
        puts e
      ensure
        delete "/api/v1/airlines/#{airline_id}"
      end
    end

    context 'when the airline already exists' do
      let(:airline_id) { 'airline_137' }
      it 'returns a conflict error' do
        post "/api/v1/airlines/#{airline_id}", params: { airline: airline_params }

        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)).to include({ 'message' => "Airline with ID #{airline_id} already exists" })
      end
    end
  end

  describe 'PUT /api/v1/airlines/{id}' do
    let(:airline_id) { 'airline_put' }

    let(:current_params) do
      {
        'name' => '40-Mile Air',
        'iata' => 'U5',
        'icao' => 'UPD',
        'callsign' => 'MILE-AIR',
        'country' => 'United States'
      }
    end
    let(:updated_params) do
      {
        'name' => '41-Mile Air',
        'iata' => 'U6',
        'icao' => 'UPE',
        'callsign' => 'UPDA-AIR',
        'country' => 'Updated States'
      }
    end

    context 'when the airline is updated successfully' do
      it 'returns the updated airline' do
        put "/api/v1/airlines/#{airline_id}", params: { airline: updated_params }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        # should be updated_params without 'id' key
        expect(JSON.parse(response.body)).to include(updated_params.except('id'))
      rescue StandardError => e
        puts e
      ensure
        delete "/api/v1/airlines/#{airline_id}"
      end
    end

    context 'when the airline is not updated successfully' do
      it 'returns a bad request error' do
        post "/api/v1/airlines/#{airline_id}", params: { airline: current_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(current_params)

        put "/api/v1/airlines/#{airline_id}", params: { airline: { name: 'temp' } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include({ 'error' => 'Invalid request',
                                                       'message' => ["Callsign can't be blank", "Iata can't be blank",
                                                                     'Iata is the wrong length (should be 2 characters)', "Icao can't be blank", 'Icao is the wrong length (should be 3 characters)', "Country can't be blank"] })
      rescue StandardError => e
        puts e
      ensure
        delete "/api/v1/airlines/#{airline_id}"
      end
    end
  end

  describe 'DELETE /api/v1/airlines/{id}' do
    let(:airline_id) { 'airline_delete' }
    let(:airline_params) do
      {
        'name' => '40-Mile Air',
        'iata' => 'Q5',
        'icao' => 'MLA',
        'callsign' => 'MILE-AIR',
        'country' => 'United States'
      }
    end

    context 'when the airline is deleted successfully' do
      it 'returns a success message' do
        # Clean up any existing test data first to ensure idempotent test
        delete "/api/v1/airlines/#{airline_id}"

        post "/api/v1/airlines/#{airline_id}", params: { airline: airline_params }
        expect(response).to have_http_status(:created)

        delete "/api/v1/airlines/#{airline_id}"

        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Airline deleted successfully' })
      end
    end

    context 'when the airline does not exist' do
      it 'returns a not found error' do
        delete "/api/v1/airlines/#{airline_id}"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => "Airline with ID #{airline_id} not found" })
      end
    end
  end

  describe 'GET /api/v1/airlines/list' do
    let(:country) { 'France' }
    let(:limit) { '10' }
    let(:offset) { '0' }

    let(:expected_airlines) do
      [
        { 'callsign' => 'REUNION', 'country' => 'France', 'iata' => 'UU', 'icao' => 'REU', 'name' => 'Air Austral' },
        { 'callsign' => 'AIRLINAIR', 'country' => 'France', 'iata' => 'A5', 'icao' => 'RLA', 'name' => 'Airlinair' },
        { 'callsign' => 'AIRFRANS', 'country' => 'France', 'iata' => 'AF', 'icao' => 'AFR', 'name' => 'Air France' },
        { 'callsign' => 'AIRCALIN', 'country' => 'France', 'iata' => 'SB', 'icao' => 'ACI',
          'name' => 'Air Caledonie International' },
        { 'callsign' => 'T&', 'country' => 'France', 'iata' => '&T', 'icao' => 'T&O',
          'name' => "Tom\\'s & co airliners" },
        { 'callsign' => 'BRITAIR', 'country' => 'France', 'iata' => 'DB', 'icao' => 'BZH', 'name' => 'Brit Air' },
        { 'callsign' => 'Vickjet', 'country' => 'France', 'iata' => 'KT', 'icao' => 'VKJ', 'name' => 'VickJet' },
        { 'callsign' => 'CORSAIR', 'country' => 'France', 'iata' => 'SS', 'icao' => 'CRL', 'name' => 'Corsairfly' },
        { 'callsign' => 'CORSICA', 'country' => 'France', 'iata' => 'XK', 'icao' => 'CCM',
          'name' => 'Corse-Mediterranee' },
        { 'callsign' => 'AIGLE AZUR', 'country' => 'France', 'iata' => 'ZI', 'icao' => 'AAF', 'name' => 'Aigle Azur' }
      ]
    end

    it 'returns a list of airlines for a given country' do
      get '/api/v1/airlines/list', params: { country:, limit:, offset: }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to eq(expected_airlines)
    end
  end

  describe 'GET /api/v1/airlines/to-airport' do
    let(:destination_airport_code) { 'JFK' }
    let(:limit) { '10' }
    let(:offset) { '0' }
    let(:expected_airlines) do
      [
        { 'callsign' => 'SPEEDBIRD', 'country' => 'United Kingdom', 'iata' => 'BA', 'icao' => 'BAW',
          'name' => 'British Airways' },
        { 'callsign' => 'AIRFRANS', 'country' => 'France', 'iata' => 'AF', 'icao' => 'AFR',
          'name' => 'Air France' },
        { 'callsign' => 'DELTA', 'country' => 'United States', 'iata' => 'DL', 'icao' => 'DAL',
          'name' => 'Delta Air Lines' },
        { 'callsign' => 'AMERICAN', 'country' => 'United States', 'iata' => 'AA', 'icao' => 'AAL',
          'name' => 'American Airlines' },
        { 'callsign' => 'HAWAIIAN', 'country' => 'United States', 'iata' => 'HA', 'icao' => 'HAL',
          'name' => 'Hawaiian Airlines' },
        { 'callsign' => 'JETBLUE', 'country' => 'United States', 'iata' => 'B6', 'icao' => 'JBU',
          'name' => 'JetBlue Airways' },
        { 'callsign' => 'FLAGSHIP', 'country' => 'United States', 'iata' => '9E', 'icao' => 'FLG',
          'name' => 'Pinnacle Airlines' },
        { 'callsign' => 'SUN COUNTRY', 'country' => 'United States', 'iata' => 'SY', 'icao' => 'SCX',
          'name' => 'Sun Country Airlines' },
        { 'callsign' => 'UNITED', 'country' => 'United States', 'iata' => 'UA', 'icao' => 'UAL',
          'name' => 'United Airlines' },
        { 'callsign' => 'U S AIR', 'country' => 'United States', 'iata' => 'US', 'icao' => 'USA',
          'name' => 'US Airways' }
      ]
    end

    context 'when destinationAirportCode is provided' do
      it 'returns a list of airlines flying to the destination airport' do
        get '/api/v1/airlines/to-airport',
            params: { destinationAirportCode: destination_airport_code, limit:, offset: }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(expected_airlines)
      end
    end

    context 'when destinationAirportCode is not provided' do
      it 'returns a bad request error' do
        get '/api/v1/airlines/to-airport', params: { limit:, offset: }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Invalid request',
                                                  'message' => 'Destination airport is missing' })
      end
    end
  end
end
