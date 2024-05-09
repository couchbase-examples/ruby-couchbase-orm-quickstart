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

      def index
        @hotels = Hotel.all
        formatted_hotels = @hotels.map { |hotel| hotel.attributes.except('id') }
        render json: formatted_hotels, status: :ok
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
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def update_with_validations
        if @hotel.update(hotel_params)
          render json: @hotel
        else
          render json: { errors: @hotel.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def destroy_with_callback
        if @hotel.destroy
          head :no_content
        else
          render json: { errors: @hotel.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/:id
      def find_hotel_by_id
        hotel = Hotel.find('hotel_id_123')
        render json: hotel
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/find_by_name
      def find_hotel_by_name
        hotel = Hotel.find_by(name: 'Windy Harbour Farm Hotel')
        render json: hotel
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/active_hotels
      def active_hotels
        active_hotels = Hotel.where(vacancy: true)
        formatted_hotels = active_hotels.map { |hotel| hotel.attributes.except('id') }
        # render just their names and total count
        render json: { hotels: formatted_hotels.map { |hotel| hotel['name'] }, total: formatted_hotels.count }
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/find_by_name_and_price
      def find_hotels_by_name_and_price
        hotels = Hotel.where("LOWER(name) LIKE '%hostel%' AND price IS NOT NULL").where(vacancy: true)
        render json: { hotels: hotels.map { |hotel| hotel.attributes.except('id') }, total: hotels.count }
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/find_by_email_domain
      def find_hotels_by_email_domain
        hotels = Hotel.where(email: /co.uk/)
        formatted_hotels = hotels.map { |hotel| hotel.attributes.except('id') }
        render json: formatted_hotels, status: :ok
        # render json: { hotels: hotels.map { |hotel| hotel.attributes.except('id') }, total: hotels.count }
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      # GET /hotels/create_and_update
      def create_and_update
        # Create a new hotel document
        hotel = Hotel.new(
          title: 'Glossop',
          name: 'Windy Harbour Farm Hotel',
          address: 'Woodhead Road',
          phone: '+44 1457 853107',
          url: 'http://www.peakdistrict-hotel.co.uk/',
          geo: { lat: 53.46327, lon: -1.943125, accuracy: 'ROOFTOP' },
          type: 'hotel',
          country: 'United Kingdom',
          city: 'Padfield',
          vacancy: false,
          description: 'Woodhead Rd, Glossop',
          free_internet: true,
          free_breakfast: false,
          free_parking: false
        )

        # Save the hotel document
        hotel.save

        # Increment the price by 100
        hotel.increment(:price, 100)

        # Decrement the price by 50
        hotel.decrement(:price, 50)

        # Append additional information to the description
        hotel.append(:description, ', additional information')

        # Prepend additional description to the existing description
        hotel.prepend(:description, 'Additional description, ')

        # Update the expiration time
        hotel.touch

        render json: hotel
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
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
