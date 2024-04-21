# frozen_string_literal: true

module Api
  module V1
    class RoutesController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create update destroy]
      before_action :set_route, only: %i[show update destroy]

      # GET /api/v1/routes/{id}
      def show
        if @route
          render json: @route, status: :ok
        else
          render json: { error: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/routes
      def create
        @route = Route.create(route_params)
        if @route
          render json: @route, status: :created
        else
          render json: { message: 'Route already exists' }, status: :conflict
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PUT /api/v1/routes/{id}
      def update
        if @route
          @route.update(route_params)
          render json: @route, status: :ok
        else
          render json: { error: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # DELETE /api/v1/routes/{id}
      def destroy
        if @route
          @route.destroy
          render json: { message: 'Route deleted successfully' }, status: :accepted
        else
          render json: { error: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # GET /api/v1/routes
      # def index
      #   routes = Route.all
      #   formatted_routes = routes.map do |route|
      #     {
      #       airline: route.airline,
      #       airlineid: route.airlineid,
      #       sourceairport: route.sourceairport,
      #       destinationairport: route.destinationairport,
      #       stops: route.stops,
      #       equipment: route.equipment,
      #       schedule: route.schedule,
      #       distance: route.distance
      #     }
      #   end
      #   render json: formatted_routes
      # rescue StandardError => e
      #   render json: { error: e.message }, status: :internal_server_error
      # end

      private

      def set_route
        @route = Route.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @route = nil
      end

      def route_params
        params.require(:route).permit(
          :id, :airline, :airlineid, :sourceairport,
          :destinationairport, :stops, :equipment, :distance,
          schedule: %i[day flight utc]
        )
      end
    end
  end
end
