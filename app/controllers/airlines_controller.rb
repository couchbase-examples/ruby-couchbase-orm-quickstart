# frozen_string_literal: true

# Controller for managing airlines
class AirlinesController < ApplicationController
  # GET /airlines
  def index
    airlines = Airline.all
    airlines.each do |foo|
      puts foo
    end
    formatted_airlines = airlines.map do |airline|
      {
        id: airline.id,
        name: airline.name,
        iata: airline.iata,
        icao: airline.icao,
        callsign: airline.callsign,
        country: airline.country
      }
    end
    render json: formatted_airlines
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # GET /airlines/:id
  def show
    airline = Airline.find(params[:id])
    render json: airline
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Airline not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # POST /airlines/:id
  def create
    airline = Airline.new(airline_params)
    if airline.save
      render json: airline, status: :created
    else
      render json: { errors: airline.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # PUT /airlines/:id
  def update
    airline = Airline.find(params[:id])
    if airline.update(airline_params)
      render json: airline
    else
      render json: { errors: airline.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # DELETE /airlines/:id
  def destroy
    airline = Airline.find(params[:id])
    airline.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Airline not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def airline_params
    params.require(:airline).permit(:name, :iata, :icao, :callsign, :country)
  end
end
