require 'couchbase-orm'

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
  n1ql :by_country, emit_key: :country, query_fn: proc { |bucket, values, options|
    offset = options.delete(:offset) || 0
    limit = options.delete(:limit) || 10
    cluster.query("SELECT * FROM `#{bucket.name}` WHERE type = 'airline' AND country = #{quote(values[0])} ORDER BY name ASC LIMIT #{limit} OFFSET #{offset}", options)
  }
end
