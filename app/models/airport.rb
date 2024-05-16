# frozen_string_literal: true

require 'couchbase-orm'

# AirportGeoCoordinates nested document
class AirportGeoCoordinates < CouchbaseOrm::NestedDocument
  attribute :lat, :float
  attribute :lon, :float
  attribute :alt, :integer

  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lon, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :alt, presence: true, numericality: { greater_than_or_equal_to: -1000, less_than_or_equal_to: 10_000 }
end

# Airport model
class Airport < CouchbaseOrm::Base
  attribute :airportname, :string
  attribute :city, :string
  attribute :country, :string
  attribute :faa, :string
  attribute :icao, :string
  attribute :tz, :string
  attribute :geo, :nested, type: AirportGeoCoordinates

  validates :airportname, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :faa, presence: true, length: { is: 3 }
  validates :icao, presence: true, length: { is: 4 }
  validates :tz, presence: true
  validates :geo, presence: true, nested: true
end
