class AirportsController < ApplicationController
  def index
    airports = Airport.all
    formatted_airports = airports.map do |airport|
      {
        id: airport.id,
        airportname: airport.airportname,
        city: airport.city,
        country: airport.country,
        faa: airport.faa,
        icao: airport.icao,
        tz: airport.tz,
        geo: {
          lat: airport.geo&.lat,
          lon: airport.geo&.lon,
          alt: airport.geo&.alt
        }
      }
    end
    render json: formatted_airports
  end

  def show
    airport = Airport.find(params[:id])
    render json: airport
  rescue Couchbase::Error::DocumentNotFound
    render json: { error: 'Airport not found' }, status: :not_found
  end

  def create
    airport = Airport.new(airport_params)
    if airport.save
      render json: airport, status: :created
    else
      render json: { errors: airport.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    airport = Airport.find(params[:id])
    if airport.update(airport_params)
      render json: airport
    else
      render json: { errors: airport.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Couchbase::Error::DocumentNotFound
    render json: { error: 'Airport not found' }, status: :not_found
  end

  def destroy
    airport = Airport.find(params[:id])
    airport.destroy
    head :no_content
  rescue Couchbase::Error::DocumentNotFound
    render json: { error: 'Airport not found' }, status: :not_found
  end

  private

  def airport_params
    params.require(:airport).permit(:airportname, :city, :country, :faa, :icao, :tz, geo: [:lat, :lon, :alt])
  end
end
