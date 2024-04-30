# frozen_string_literal: true

module Api
  module V1
    class RoutesController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create update destroy]
      before_action :set_route, only: %i[show update destroy]

      # GET /api/v1/routes/{id}
      def show
        if @route
          render json: @route.attributes.except('id'), status: :ok
        else
          render json: { message: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Route not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/routes/{id}
      def create
        @route = Route.find_by(id: params[:id])
        if @route
          render json: { message: "Route with ID #{params[:id]} already exists" }, status: :conflict
        else
          @route = Route.new(route_params)
          if @route.save
            render json: @route, status: :created
          else
            render json: { error: 'Failed to create route', message: @route.errors.full_messages },
                   status: :bad_request
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PUT /api/v1/routes/{id}
      def update
        @route = Route.new(route_params)
        if @route.save
          render json: @route.attributes.except('id'), status: :ok
        else
          render json: { error: 'Invalid request', message: @route.errors.full_messages },
                 status: :bad_request
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # DELETE /api/v1/routes/{id}
      def destroy
        @route = Route.find_by(id: params[:id])
        if @route
          if @route.destroy
            render json: { message: 'Route deleted successfully' }, status: :accepted
          else
            render json: { error: 'Failed to delete route', message: @route.errors.full_messages },
                   status: :bad_request
          end
        else
          render json: { message: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Route not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # GET /api/v1/routes/list
      def index
        routes = Route.all
        formatted_routes = routes.map do |route|
          {
            id: route.id,
            type: route.type,
            airline: route.airline,
            airlineid: route.airlineid,
            sourceairport: route.sourceairport,
            destinationairport: route.destinationairport,
            stops: route.stops,
            equipment: route.equipment,
            schedule: route.schedule.map do |schedule_detail|
              {
                day: schedule_detail.day,
                utc: schedule_detail.utc,
                flight: schedule_detail.flight
              }
            end,
            distance: route.distance
          }
        end
        render json: formatted_routes
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      private

      def set_route
        @route = Route.find_by(id: params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @route = nil
      end

      def route_params
        params.require(:route).permit(:id, :type, :airline, :airlineid, :sourceairport, :destinationairport,
                                      :stops, :equipment, :distance, schedule: %i[day utc flight])
      end
    end
  end
end
