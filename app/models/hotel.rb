class HotelGeoCoordinates < CouchbaseOrm::NestedDocument
  attribute :lat, :float
  attribute :lon, :float
  attribute :accuracy, :string

  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :lon, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :accuracy, presence: true
end

class Review < CouchbaseOrm::NestedDocument
  attribute :author, :string
  attribute :content, :string
  attribute :ratings, :integer
  attribute :date, :datetime, precision: 6

  validates :author, :content, :rating, presence: true
  validates :ratings, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end

class Hotel < CouchbaseOrm::Base
  before_create :do_something_before_create
  after_create :do_something_after_create
  before_save :do_something_before_save
  after_save :do_something_after_save
  before_update :do_something_before_update
  after_update :do_something_after_update
  before_destroy :do_something_before_destroy
  after_destroy :do_something_after_destroy

  before_save :encrypt_address

  private

  def do_something_before_create
    puts "Before create: #{self}"
  end

  def do_something_after_create
    puts "After create: #{self}"
  end

  def do_something_before_save
    puts "Before save: #{self}"
  end

  def do_something_after_save
    puts "After save: #{self}"
  end

  def do_something_before_update
    puts "Before update: #{self}"
  end

  def do_something_after_update
    puts "After update: #{self}"
  end

  def do_something_before_destroy
    puts "Before destroy: #{self}"
  end

  def do_something_after_destroy
    puts "After destroy: #{self}"
  end

  attribute :title, :string
  attribute :name, :string
  attribute :address, :encrypted
  attribute :directions, :string
  attribute :phone, :string
  attribute :tollfree, :string
  attribute :email, :string
  attribute :fax, :string
  attribute :url, :string
  attribute :checkin, :string
  attribute :checkout, :string
  attribute :price, :string
  attribute :geo, :nested, type: HotelGeoCoordinates
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

  # Validations
  validates :title, :name, :address, :phone, :email, :fax, :url, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
  # validates :phone, format: { with: /\A\d{10}\z/, message: 'must be a valid 10-digit phone number' }
  validates :phone, format: { numericality: { only_integer: true }, length: { is: 10 }, message: 'must be a valid 10-digit phone number' }
  validates :fax, format: { with: /\A\d{10}\z/, message: 'must be a valid 10-digit fax number' }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' }
  validates :title, :name, :address, :city, :state, :country, length: { maximum: 255 }
  # validates :title, :name, uniqueness: true
  # validates :price, numericality: { greater_than_or_equal_to: 0 } # its a string
  validates :vacancy, inclusion: { in: [true, false] }
  validates :public_likes, exclusion: { in: [nil] }

  validate :custom_validation

  # n1ql :find_by_name_n1ql, 'SELECT * FROM hotels WHERE name = $1'
  n1ql :find_by_name_n1ql, query_fn: proc { |bucket, values, options|
                                       cluster.query('SELECT * FROM hotels WHERE name = $1', values:, options:)
                                     }

  def custom_validation
    return unless title.include?('funny')

    errors.add(:title, 'cannot be funny')
  end

  def set_timestamps
    current_time = Time.now
    self.created_at = current_time if new_record?
    self.updated_at = current_time
  end

  def encrypt_address
    self.address = encrypt(address) if address_changed?
  end

  def encrypt(data)
    # Implement your encryption logic here
    # For example, using a simple XOR encryption
    key = 'secret_key'
    data.chars.map { |c| (c.ord ^ key.ord).chr }.join
  end
end
