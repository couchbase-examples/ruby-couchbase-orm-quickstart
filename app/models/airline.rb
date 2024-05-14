# frozen_string_literal: true

require 'couchbase-orm'

# Airline model
class Airline < CouchbaseOrm::Base
  attribute :name, :string
  attribute :callsign, :string
  attribute :iata, :string
  attribute :icao, :string
  attribute :country, :string
  # attribute :destinationAirportCode, :string

  validates :name, presence: true
  validates :callsign, presence: true
  validates :iata, presence: true, length: { is: 2 }
  validates :icao, presence: true, length: { is: 3 }
  validates :country, presence: true

  # Custom N1QL query to list airlines by country with pagination
  n1ql :list_by_country, query_fn: proc { |bucket, values, options|
    cluster.query("SELECT raw meta().id FROM `#{bucket.name}` WHERE type = 'airline' AND country = #{quote(values[0])} LIMIT #{values[1]} OFFSET #{values[2]}", options)
  }

  n1ql :to_airport, query_fn: proc { |bucket, values, options|
    cluster.query("SELECT raw META(air).id FROM (SELECT DISTINCT META(airline).id AS airlineId FROM `#{bucket.name}` AS route JOIN `#{bucket.name}` AS airline ON route.airlineid = META(airline).id WHERE route.destinationairport = #{quote(values[0])}) AS subquery JOIN `#{bucket.name}` AS air ON META(air).id = subquery.airlineId LIMIT #{values[1]} OFFSET #{values[2]}", options)
  }
end
