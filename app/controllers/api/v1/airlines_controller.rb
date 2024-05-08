# frozen_string_literal: true

module Api
  module V1
    class AirlinesController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create update destroy]
      before_action :set_airline, only: %i[show update destroy]

      # GET /api/v1/airlines/{id}
      def show
        if @airline
          render json: @airline.attributes.except('id'), status: :ok
        else
          render json: { message: "Airline with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Airline not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/airlines/{id}
      def create
        @airline = Airline.find_by(id: params[:id])
        if @airline
          render json: { message: "Airline with ID #{params[:id]} already exists" }, status: :conflict
        else
          @airline = Airline.new(airline_params.merge(id: params[:id]))
          if @airline.save
            render json: @airline, status: :created
          else
            render json: { error: 'Failed to create airline', message: @airline.errors.full_messages },
                   status: :bad_request
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PUT /api/v1/airlines/{id}
      def update
        @airline = Airline.new(airline_params.merge(id: params[:id]))
        if @airline.save
          render json: @airline.attributes.except('id'), status: :ok
        else
          render json: { error: 'Invalid request', message: @airline.errors.full_messages },
                 status: :bad_request

        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # DELETE /api/v1/airlines/{id}
      def destroy
        @airline = Airline.find_by(id: params[:id])
        if @airline
          if @airline.destroy
            render json: { message: 'Airline deleted successfully' }, status: :accepted
          else
            render json: { error: 'Failed to delete airline', message: @airline.errors.full_messages },
                   status: :bad_request
          end
        else
          render json: { message: "Airline with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Airline not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # GET /api/v1/airlines/list
      def index
        country = params[:country]
        page = params[:page].to_i || 1
        per_page = params[:per_page].to_i || 10

        offset = (page - 1) * per_page

        airlines = if country.present?
                     Airline.where(country:)
                   else
                     Airline.all
                   end
                   .pluck(:callsign, :country, :iata, :icao, :id, :name)
        #  .order(:name)
        #  .offset(offset)
        #  .limit(per_page)

        formatted_airlines = airlines.map do |airline|
          {
            callsign: airline[0],
            country: airline[1],
            iata: airline[2],
            icao: airline[3],
            id: airline[4],
            name: airline[5]
          }
        end

        render json: formatted_airlines
      end

      # GET /api/v1/airlines/to-airport
      def to_airport
        raise ArgumentError, 'Destination airport is missing' unless params[:destination_airport].present?

        destination_airport = params[:destination_airport]
        page = params[:page].to_i || 1
        per_page = params[:per_page].to_i || 10

        offset = (page - 1) * per_page

        airline_ids = Route.where(destinationairport: destination_airport)
                           #  .distinct(:airlineid)
                           .pluck(:airlineid)

        airlines = Airline.where(id: airline_ids)
                          .pluck(:callsign, :country, :iata, :icao, :id, :name)
        # .offset(offset)
        # .limit(per_page)

        formatted_airlines = airlines.map do |airline|
          {
            callsign: airline[0],
            country: airline[1],
            iata: airline[2],
            icao: airline[3],
            id: airline[4],
            name: airline[5]
          }
        end

        render json: formatted_airlines
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      private

      def set_airline
        @airline = Airline.find_by(id: params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @airline = nil
      end

      def airline_params
        params.require(:airline).permit(:id, :name, :iata, :icao, :callsign, :country)
      end
    end
  end
end