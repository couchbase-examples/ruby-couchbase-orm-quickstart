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

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :type, inclusion: { in: ['hotel', 'motel', 'resort'] }
  validates :url, format: { with: URI.regexp, message: 'must be a valid URL' }
  validates :description, length: { maximum: 500 }

  before_create :set_alias
  before_save :set_timestamps
  after_create :send_welcome_email
  before_destroy :check_reviews

  private

  def set_timestamps
    current_time = Time.now
    self.created_at = current_time if new_record?
    self.updated_at = current_time
  end

  def send_welcome_email
    # Code to send welcome email after hotel creation
  end

  def check_reviews
    if reviews.any?
      errors.add(:base, 'Cannot delete hotel with existing reviews')
      throw :abort
    end
  end
end
