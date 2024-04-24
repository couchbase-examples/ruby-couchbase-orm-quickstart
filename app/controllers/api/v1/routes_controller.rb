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
        render json: { error: "Route not found", message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/routes/{id}
      def create
        @route = Route.find_by(id: params[:id])
        if @route
          render json: { message: "Route with ID #{params[:id]} already exists" }, status: :conflict
        else
          @route = Route.create(route_params)
          if @route
            render json: @route, status: :created
          else
            render json: { error: 'Failed to create route' }, status: :bad_request
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PATCH/PUT /api/v1/routes/{id}
      def update
        if @route
          if @route.update(route_params)
            render json: @route.attributes.except('id'), status: :ok
          else
            render json: { message: 'Failed to update route' }, status: :bad_request
          end
        else
          @route = Route.create(route_params)
          if @route
            render json: @route.attributes.except('id'), status: :ok
          else
            render json: { message: 'Route already exists' }, status: :conflict
          end
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
            render json: { message: 'Failed to delete route' }, status: :bad_request
          end
        else
          render json: { message: "Route with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: "Route not found", message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      private

      def set_route
        @route = Route.find_by(id: params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @route = nil
      end

      def route_params
        params.require(:route).permit(:id, :type, :airline, :airlineid, :sourceairport, :destinationairport, :stops, :equipment, :distance, schedule: [:day, :utc, :flight])
      end
    end
  end
end
