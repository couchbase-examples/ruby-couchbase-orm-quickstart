# frozen_string_literal: true

module Api
  module V1
    class AirportsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create update destroy]
      before_action :set_airport, only: %i[show update destroy]

      # GET /api/v1/airports/{id}
      def show
        if @airport
          render json: @airport.attributes.except('id'), status: :ok
        else
          render json: { message: "Airport with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: "Airport not found", message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/airports/{id}
      def create
        @airport = Airport.find_by(id: params[:id])
        if @airport
          render json: { message: "Airport with ID #{params[:id]} already exists" }, status: :conflict
        else
          @airport = Airport.create(airport_params)
          if @airport
            render json: @airport, status: :created
          else
            render json: { error: 'Failed to create airport' }, status: :bad_request
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PATCH/PUT /api/v1/airports/{id}
      def update
        if @airport
          if @airport.update(airport_params)
            render json: @airport.attributes.except('id'), status: :ok
          else
            render json: { message: 'Failed to update airport' }, status: :bad_request
          end
        else
          @airport = Airport.create(airport_params)
          if @airport
            render json: @airport.attributes.except('id'), status: :ok
          else
            render json: { message: 'Airport already exists' }, status: :conflict
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # DELETE /api/v1/airports/{id}
      def destroy
        @airport = Airport.find_by(id: params[:id])
        if @airport
          if @airport.destroy
            render json: { message: 'Airport deleted successfully' }, status: :accepted
          else
            render json: { message: 'Failed to delete airport' }, status: :bad_request
          end
        else
          render json: { message: "Airport with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: "Airport not found", message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      private

      def set_airport
        @airport = Airport.find_by(id: params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @airport = nil
      end

      def airport_params
        params.require(:airport).permit(:id, :airportname, :city, :country, :faa, :icao, :tz, geo: [:lat, :lon, :alt])
      end
    end
  end
end
