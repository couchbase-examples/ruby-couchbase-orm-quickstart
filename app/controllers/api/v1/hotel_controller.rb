# app/controllers/api/v1/hotels_controller.rb
module Api
  module V1
    class HotelsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: %i[create update destroy]
      before_action :set_hotel, only: %i[show update destroy]

      # GET /api/v1/hotels/{id}
      def show
        if @hotel
          render json: @hotel.attributes.except('id'), status: :ok
        else
          render json: { message: "Hotel with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Hotel not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # POST /api/v1/hotels/{id}
      def create
        @hotel = Hotel.find_by(id: params[:id])
        if @hotel
          render json: { message: "Hotel with ID #{params[:id]} already exists" }, status: :conflict
        else
          @hotel = Hotel.new(hotel_params.merge(id: params[:id]))
          if @hotel.save
            render json: @hotel, status: :created
          else
            render json: { error: 'Failed to create hotel', message: @hotel.errors.full_messages },
                   status: :bad_request
          end
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # PUT /api/v1/hotels/{id}
      def update
        @hotel = Hotel.new(hotel_params.merge(id: params[:id]))
        if @hotel.save
          render json: @hotel.attributes.except('id'), status: :ok
        else
          render json: { error: 'Invalid request', message: @hotel.errors.full_messages },
                 status: :bad_request
        end
      rescue ArgumentError => e
        render json: { error: 'Invalid request', message: e.message }, status: :bad_request
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      # DELETE /api/v1/hotels/{id}
      def destroy
        @hotel = Hotel.find_by(id: params[:id])
        if @hotel
          if @hotel.destroy
            render json: { message: 'Hotel deleted successfully' }, status: :accepted
          else
            render json: { error: 'Failed to delete hotel', message: @hotel.errors.full_messages },
                   status: :bad_request
          end
        else
          render json: { message: "Hotel with ID #{params[:id]} not found" }, status: :not_found
        end
      rescue Couchbase::Error::DocumentNotFound => e
        render json: { error: 'Hotel not found', message: e.message }, status: :not_found
      rescue StandardError => e
        render json: { error: 'Internal server error', message: e.message }, status: :internal_server_error
      end

      def create_with_validations
        @hotel = Hotel.new(hotel_params)
        if @hotel.save
          render json: @hotel, status: :created
        else
          render json: { errors: @hotel.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update_with_validations
        if @hotel.update(hotel_params)
          render json: @hotel
        else
          render json: { errors: @hotel.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy_with_callback
        if @hotel.destroy
          head :no_content
        else
          render json: { errors: @hotel.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_hotel
        @hotel = Hotel.find_by(id: params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @hotel = nil
      end

      def hotel_params
        params.require(:hotel).permit(:id, :title, :name, :address, :directions, :phone, :tollfree, :email, :fax,
                                      :url, :checkin, :checkout, :price, :type, :country, :city, :state,
                                      :vacancy, :description, :alias, :pets_ok, :free_breakfast, :free_internet,
                                      :free_parking, :created_at, :updated_at,
                                      geo: %i[lat lon accuracy],
                                      reviews: [:content, { ratings: {} }, :author, :date],
                                      public_likes: [])
      end
    end
  end
end
