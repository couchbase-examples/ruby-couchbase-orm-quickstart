# frozen_string_literal: true

# app/models/hotel.rb
class Hotel < CouchbaseOrm::Base
  attribute :title, :string
  attribute :name, :string
  attribute :address, :string
  attribute :directions, :string
  attribute :phone, :string
  attribute :tollfree, :string
  attribute :email, :string
  attribute :fax, :string
  attribute :url, :string
  attribute :checkin, :string
  attribute :checkout, :string
  attribute :price, :string
  attribute :geo, :nested, type: GeoCoordinates
  attribute :type, :string
  attribute :country, :string
  attribute :city, :string
  attribute :state, :string
  attribute :reviews, :array, type: Review
  attribute :public_likes, :array, type: :string
  attribute :vacancy, :boolean
  attribute :description, :string
  attribute :alias, :string
  attribute :pets_ok, :boolean
  attribute :free_breakfast, :boolean
  attribute :free_internet, :boolean
  attribute :free_parking, :boolean
  attribute :created_at, :datetime, precision: 6
  attribute :updated_at, :datetime, precision: 6

  before_save :set_timestamps

  private

  def set_timestamps
    current_time = Time.now
    self.created_at = current_time if new_record?
    self.updated_at = current_time
  end
end

# app/models/geo_coordinates.rb
class GeoCoordinates < CouchbaseOrm::NestedDocument
  attribute :lat, :float
  attribute :lon, :float
  attribute :accuracy, :string
end

# app/models/review.rb
class Review < CouchbaseOrm::NestedDocument
  attribute :content, :string
  attribute :ratings, :hash
  attribute :author, :string
  attribute :date, :datetime
end
