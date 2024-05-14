# frozen_string_literal: true

require 'couchbase-orm'

# Airline model
class Airline < CouchbaseOrm::Base
  attribute :name, :string
  attribute :callsign, :string
  attribute :iata, :string
  attribute :icao, :string
  attribute :country, :string

  validates :name, presence: true
  validates :callsign, presence: true
  validates :iata, presence: true, length: { is: 2 }
  validates :icao, presence: true, length: { is: 3 }
  validates :country, presence: true

  # Custom N1QL query to list airlines by country with pagination
  n1ql :list_by_country, emit_key: [:country], query_fn: proc { |bucket, values, options|
    # limit = options[:limit] || 10
    # offset = options[:offset] || 0
    cluster.query("SELECT raw meta().id FROM `#{bucket.name}` WHERE type = 'airline' AND country = #{quote(values[0])} LIMIT 10 OFFSET 0", options)
  }
  # n1ql :by_country,
  #      "SELECT * FROM `#{bucket.name}` WHERE type = 'airline' AND country = $1 ORDER BY name ASC LIMIT $2 OFFSET $3"

  # SELECT
  # air.callsign,
  # air.country,
  # air.iata,
  # air.icao,
  # air.id,
  # air.name,
  # air.type
  # FROM (
  # SELECT DISTINCT META(airline).id AS airlineId
  # FROM route
  # JOIN airline ON route.airlineid = META(airline).id
  # WHERE route.destinationairport = ?
  # ) AS subquery
  # JOIN airline AS air ON META(air).id = subquery.airlineId;

  n1ql :to_airport, emit_key: :icao, query_fn: proc { |bucket, values, options|
    cluster.query("SELECT raw meta().id FROM `#{bucket.name}` WHERE type = 'airline' AND icao = #{quote(values[0])} LIMIT 10 OFFSET 0", options)
  }
end
