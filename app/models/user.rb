class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :points, :integer, default: 0

  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
end

class Post < CouchbaseOrm::Base
  attribute :title, :string
  attribute :content, :string

  belongs_to :user
end

class Document < CouchbaseOrm::Base
  attribute :name, :string
  attribute :content, :string
end
