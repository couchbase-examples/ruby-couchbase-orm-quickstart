class ScheduleDetail < CouchbaseOrm::NestedDocument
  attribute :day, :integer
  attribute :utc, :string
  attribute :flight, :string

  validates :day, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :utc, presence: true
  validates :flight, presence: true
end

class Route < CouchbaseOrm::Base
  attribute :airline, :string
  attribute :airlineid, :string
  attribute :sourceairport, :string
  attribute :destinationairport, :string
  attribute :stops, :integer
  attribute :equipment, :string
  attribute :schedule, :array, type: ScheduleDetail
  attribute :distance, :float

  validates :airline, presence: true
  validates :airlineid, presence: true
  validates :sourceairport, presence: true
  validates :destinationairport, presence: true
  validates :stops, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :equipment, presence: true
  validates :schedule, presence: true
  validates :distance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  n1ql :direct_connections, query_fn: proc { |bucket, values, options|
    cluster.query("SELECT distinct raw meta(route).id FROM `#{bucket.name}` AS airport JOIN `#{bucket.name}` AS route ON route.sourceairport = airport.faa WHERE airport.faa = #{quote(values[0])} AND route.stops = 0 LIMIT #{values[1]} OFFSET #{values[2]}", options)
  }
end
