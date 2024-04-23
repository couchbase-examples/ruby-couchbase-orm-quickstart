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
        expect(JSON.parse(response.body)).to include({ 'error' => "Airline with ID #{airline_id} already exists" })
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
        expect(JSON.parse(response.body)).to include(updated_params)
      rescue StandardError => e
        puts e
      ensure
        puts "Deleting airline with ID #{airline_id}"
        delete "/api/v1/airlines/#{airline_id}"
      end
    end

    context 'when the airline is not updated successfully' do
      it 'returns a bad request error' do
        post "/api/v1/airlines/#{airline_id}", params: { airline: current_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(current_params)

        put "/api/v1/airlines/#{airline_id}", params: { airline: { name: '' } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include({ 'error' => 'Invalid request',
                                                       'message' => 'Missing fields: iata, icao, callsign, country' })
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
        post "/api/v1/airlines/#{airline_id}", params: { airline: airline_params }

        delete "/api/v1/airlines/#{airline_id}"

        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Airline deleted successfully' })
      end
    end

    context 'when the airline does not exist' do
      it 'returns a not found error' do
        delete "/api/v1/airlines/#{airline_id}"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => "Airline with ID #{airline_id} not found" })
      end
    end
  end

  describe 'GET /api/v1/airlines/list' do
    let(:country) { 'United States' }
    let(:limit) { '10' }
    let(:offset) { '0' }
    let(:expected_airlines) do
      [
        { 'name' => '40-Mile Air', 'iata' => 'Q5', 'icao' => 'MLA', 'callsign' => 'MILE-AIR',
          'country' => 'United States' },
        { 'name' => 'Texas Wings', 'iata' => 'TQ', 'icao' => 'TXW', 'callsign' => 'TXW', 'country' => 'United States' },
        { 'name' => 'Atifly', 'iata' => 'A1', 'icao' => 'A1F', 'callsign' => 'atifly', 'country' => 'United States' },
        { 'name' => 'Locair', 'iata' => 'ZQ', 'icao' => 'LOC', 'callsign' => 'LOCAIR', 'country' => 'United States' },
        { 'name' => 'SeaPort Airlines', 'iata' => 'K5', 'icao' => 'SQH', 'callsign' => 'SASQUATCH',
          'country' => 'United States' },
        { 'name' => 'Alaska Central Express', 'iata' => 'KO', 'icao' => 'AER', 'callsign' => 'ACE AIR',
          'country' => 'United States' },
        { 'name' => 'AirTran Airways', 'iata' => 'FL', 'icao' => 'TRS', 'callsign' => 'CITRUS',
          'country' => 'United States' },
        { 'name' => 'U.S. Air', 'iata' => '-+', 'icao' => '--+', 'callsign' => nil, 'country' => 'United States' },
        { 'name' => 'PanAm World Airways', 'iata' => 'WQ', 'icao' => 'PQW', 'callsign' => nil,
          'country' => 'United States' },
        { 'name' => 'Bemidji Airlines', 'iata' => 'CH', 'icao' => 'BMJ', 'callsign' => 'BEMIDJI',
          'country' => 'United States' }
      ]
    end

    it 'returns a list of airlines for a given country' do
      get '/api/v1/airlines/list', params: { country: country, limit: limit, offset: offset }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to eq(expected_airlines)
    end
  end

  describe 'GET /api/v1/airlines/to-airport' do
    let(:destination_airport_code) { 'MRS' }
    let(:limit) { '10' }
    let(:offset) { '0' }
    let(:expected_airlines) do
      [
        {
          'callsign' => 'AIRFRANS',
          'country' => 'France',
          'iata' => 'AF',
          'icao' => 'AFR',
          'name' => 'Air France'
        },
        {
          'callsign' => 'SPEEDBIRD',
          'country' => 'United Kingdom',
          'iata' => 'BA',
          'icao' => 'BAW',
          'name' => 'British Airways'
        },
        {
          'callsign' => 'AIRLINAIR',
          'country' => 'France',
          'iata' => 'A5',
          'icao' => 'RLA',
          'name' => 'Airlinair'
        },
        {
          'callsign' => 'STARWAY',
          'country' => 'France',
          'iata' => 'SE',
          'icao' => 'SEU',
          'name' => 'XL Airways France'
        },
        {
          'callsign' => 'TWINJET',
          'country' => 'France',
          'iata' => 'T7',
          'icao' => 'TJT',
          'name' => 'Twin Jet'
        },
        {
          'callsign' => 'EASY',
          'country' => 'United Kingdom',
          'iata' => 'U2',
          'icao' => 'EZY',
          'name' => 'easyJet'
        },
        {
          'callsign' => 'AMERICAN',
          'country' => 'United States',
          'iata' => 'AA',
          'icao' => 'AAL',
          'name' => 'American Airlines'
        },
        {
          'callsign' => 'CORSICA',
          'country' => 'France',
          'iata' => 'XK',
          'icao' => 'CCM',
          'name' => 'Corse-Mediterranee'
        }
      ]
    end

    context 'when destinationAirportCode is provided' do
      it 'returns a list of airlines flying to the destination airport' do
        get '/api/v1/airlines/to-airport',
            params: { destinationAirportCode: destination_airport_code, limit: limit, offset: offset }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq(expected_airlines)
      end
    end

    context 'when destinationAirportCode is not provided' do
      it 'returns a bad request error' do
        get '/api/v1/airlines/to-airport', params: { limit: limit, offset: offset }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Destination airport code is required' })
      end
    end
  end
end
