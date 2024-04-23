require 'rails_helper'

RSpec.describe 'Routes API', type: :request do
  describe 'GET /api/v1/routes/{id}' do
    let(:route_id) { 'route_10209' }
    let(:expected_route) do
      {
        'airline' => 'AH',
        'airlineid' => 'airline_794',
        'sourceairport' => 'MRS',
        'destinationairport' => 'TLM',
        'stops' => 0,
        'equipment' => '736',
        'schedule' => [
          { 'day' => 0, 'flight' => 'AH705',
            'utc' => '22:18:00' }, { 'day' => 0, 'flight' => 'AH413', 'utc' => '08:47:00' }, { 'day' => 0, 'flight' => 'AH284', 'utc' => '04:25:00' }, { 'day' => 1, 'flight' => 'AH800', 'utc' => '10:05:00' }, { 'day' => 1, 'flight' => 'AH448', 'utc' => '04:59:00' }, { 'day' => 1, 'flight' => 'AH495', 'utc' => '20:17:00' }, { 'day' => 1, 'flight' => 'AH837', 'utc' => '08:30:00' }, { 'day' => 2, 'flight' => 'AH344', 'utc' => '08:32:00' }, { 'day' => 2, 'flight' => 'AH875', 'utc' => '06:28:00' }, { 'day' => 3, 'flight' => 'AH781', 'utc' => '21:15:00' }, { 'day' => 4, 'flight' => 'AH040', 'utc' => '12:57:00' }, { 'day' => 5, 'flight' => 'AH548', 'utc' => '23:09:00' }, { 'day' => 6, 'flight' => 'AH082', 'utc' => '22:47:00' }, { 'day' => 6, 'flight' => 'AH434', 'utc' => '06:12:00' }, { 'day' => 6, 'flight' => 'AH831', 'utc' => '13:10:00' }, { 'day' => 6, 'flight' => 'AH144', 'utc' => '02:48:00' }, { 'day' => 6, 'flight' => 'AH208', 'utc' => '22:39:00' }
        ],
        'distance' => 1097.2184613947677
      }
    end

    it 'returns the route' do
      get "/api/v1/routes/#{route_id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body)).to include(expected_route)
    end
  end

  describe 'POST /api/v1/routes/{id}' do
    let(:route_id) { 'route_post' }
    let(:route_params) do
      {
        'airline' => 'AF',
        'airlineid' => 'airline_137',
        'sourceairport' => 'TLV',
        'destinationairport' => 'MRS',
        'stops' => 0,
        'equipment' => '320',
        'schedule' => [
          { 'day' => 0, 'utc' => '10:13:00', 'flight' => 'AF198' },
          { 'day' => 0, 'utc' => '19:14:00', 'flight' => 'AF547' }
          # Add more schedule items as needed
        ],
        'distance' => 2881.617376098415
      }
    end

    context 'when the route is created successfully' do
      it 'returns the created route' do
        post "/api/v1/routes/#{route_id}", params: { route: route_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(route_params)

        delete "/api/v1/routes/#{route_id}"
      end
    end

    context 'when the route already exists' do
      let(:route_id) { 'route_10209' }
      it 'returns a conflict error' do
        post "/api/v1/routes/#{route_id}", params: { route: route_params }

        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)).to include({ 'error' => 'Route already exists' })
      end
    end
  end

  describe 'PUT /api/v1/routes/{id}' do
    let(:route_id) { 'route_put' }
    let(:current_params) do
      {
        'airline' => 'AF',
        'airlineid' => 'airline_137',
        'sourceairport' => 'TLV',
        'destinationairport' => 'MRS',
        'stops' => 0,
        'equipment' => '320',
        'schedule' => [
          { 'day' => 0, 'utc' => '10:13:00', 'flight' => 'AF198' },
          { 'day' => 0, 'utc' => '19:14:00', 'flight' => 'AF547' }
          # Add more schedule items as needed
        ],
        'distance' => 3000
      }
    end
    let(:updated_params) do
      {
        'airline' => 'AF',
        'airlineid' => 'airline_137',
        'sourceairport' => 'TLV',
        'destinationairport' => 'CDG',
        'stops' => 1,
        'equipment' => '321',
        'schedule' => [
          { 'day' => 1, 'utc' => '11:13:00', 'flight' => 'AF199' },
          { 'day' => 1, 'utc' => '20:14:00', 'flight' => 'AF548' }
          # Add more schedule items as needed
        ],
        'distance' => 3500
      }
    end

    context 'when the route is updated successfully' do
      it 'returns the updated route' do
        put "/api/v1/routes/#{route_id}", params: { route: updated_params }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(updated_params)

        delete "/api/v1/routes/#{route_id}"
      end
    end

    context 'when the route is not updated successfully' do
      it 'returns a bad request error' do
        post "/api/v1/routes/#{route_id}", params: { route: current_params }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to include(current_params)

        put "/api/v1/routes/#{route_id}", params: { route: { airline: '' } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include({ 'error' => 'Invalid request' })

        delete "/api/v1/routes/#{route_id}"
      end
    end
  end

  describe 'DELETE /api/v1/routes/{id}' do
    let(:route_id) { 'route_delete' }
    let(:route_params) do
      {
        'airline' => 'AF',
        'airlineid' => 'airline_137',
        'sourceairport' => 'TLV',
        'destinationairport' => 'MRS',
        'stops' => 0,
        'equipment' => '320',
        'schedule' => [
          { 'day' => 0, 'utc' => '10:13:00', 'flight' => 'AF198' },
          { 'day' => 0, 'utc' => '19:14:00', 'flight' => 'AF547' }
          # Add more schedule items as needed
        ],
        'distance' => 2881.617376098415
      }
    end

    context 'when the route is deleted successfully' do
      it 'returns a success message' do
        post "/api/v1/routes/#{route_id}", params: { route: route_params }

        delete "/api/v1/routes/#{route_id}"

        expect(response).to have_http_status(:accepted)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Route deleted successfully' })
      end
    end

    context 'when the route does not exist' do
      it 'returns a not found error' do
        delete "/api/v1/routes/#{route_id}"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Route not found' })
      end
    end
  end
end
