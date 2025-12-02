# frozen_string_literal: true

module Api
  module V1
    # Health check endpoint for monitoring service status
    class HealthController < ApplicationController
      def show
        health_status = {
          status: 'healthy',
          timestamp: Time.current.iso8601,
          services: {
            couchbase: check_couchbase_orm
          }
        }

        all_up = health_status[:services].values.all? { |s| s[:status] == 'up' }
        status_code = all_up ? :ok : :service_unavailable

        render json: health_status, status: status_code
      end

      private

      def check_couchbase_orm
        # Test ORM connection by attempting to access the bucket
        bucket_name = Airline.bucket.name
        { status: 'up', message: "Connected to Couchbase bucket: #{bucket_name}" }
      rescue StandardError => e
        { status: 'down', message: e.message }
      end
    end
  end
end
