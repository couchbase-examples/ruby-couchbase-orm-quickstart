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
end
