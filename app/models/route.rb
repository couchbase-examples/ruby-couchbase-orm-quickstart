class ScheduleDetail < CouchbaseOrm::NestedDocument
  attribute :day, :integer
  attribute :utc, :string
  attribute :flight, :string

  validates :day, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :utc, presence: true
  validates :flight, presence: true
end

class Route < CouchbaseOrm::Base
  attribute :type, :string
  attribute :airline, :string
  attribute :airlineid, :string
  attribute :sourceairport, :string
  attribute :destinationairport, :string
  attribute :stops, :integer
  attribute :equipment, :string
  attribute :schedule, :array, of: ScheduleDetail
  attribute :distance, :float

  validates :type, presence: true
  validates :airline, presence: true
  validates :airlineid, presence: true
  validates :sourceairport, presence: true
  validates :destinationairport, presence: true
  validates :stops, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :equipment, presence: true
  validates :schedule, presence: true
  validates :distance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
