---
sidebar_position: 09
---

# Nested Documents

CouchbaseOrm supports nested documents, which allow you to store complex, hierarchical data structures within a single Couchbase document. Nested documents are useful when you have related data that you want to store together with the parent document for performance or consistency reasons.

## 9.1. Defining Nested Documents

To define an nested document, you create a new class that inherits from `CouchbaseOrm::NestedDocument`.

```ruby
class Address < CouchbaseOrm::NestedDocument
  attribute :street, :string
  attribute :city, :string
  attribute :country, :string
end

class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :address, Address
end
```

In this example, we define an `Address` class as an nested document and include it as an attribute in the `User` model using the `attribute` method.

## 9.2. Embedding Documents

To embed a document within a parent document, you can assign an instance of the nested document class to the corresponding attribute.

```ruby
user = User.new(name: 'John Doe', email: 'john@example.com')
user.address = Address.new(street: '123 Main St', city: 'New York', country: 'USA')
user.save
```

When saving the parent document (`User` in this case), CouchbaseOrm automatically serializes the nested document (`Address`) and stores it as a nested object within the parent document.

## 9.3. Accessing Nested Documents

To access an nested document, you can simply call the corresponding attribute on the parent document.

```ruby
user = User.find('user_id')
address = user.address
puts address.street
```

CouchbaseOrm automatically deserializes the nested document and returns an instance of the nested document class.

## 9.4. Updating Nested Documents

To update an nested document, you can modify the attributes of the nested document instance and save the parent document.

```ruby
user = User.find('user_id')
user.address.city = 'Los Angeles'
user.save
```

CouchbaseOrm will serialize the updated nested document and save it along with the parent document.

## 9.5. Embedding Multiple Documents

You can also embed multiple documents within a parent document using an array attribute.

```ruby
class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :addresses, :array, type: Address
end

user = User.new(name: 'John Doe', email: 'john@example.com')
user.addresses = [
  Address.new(street: '123 Main St', city: 'New York', country: 'USA'),
  Address.new(street: '456 Oak St', city: 'San Francisco', country: 'USA')
]
user.save
```

In this example, the `User` model has an `addresses` attribute that is an array of `Address` nested documents. You can assign an array of `Address` instances to the `addresses` attribute and save the parent document.

## 9.6. Querying Nested Documents

CouchbaseOrm allows you to query nested documents using dot notation and attribute conditions.

```ruby
users = User.where('address.city': 'New York')
```

This query retrieves all users who have an nested `Address` document with the `city` attribute set to `'New York'`.

You can also query nested documents within an array attribute.

```ruby
users = User.where('addresses.country': 'USA')
```

This query retrieves all users who have at least one nested `Address` document with the `country` attribute set to `'USA'`.

## 9.7. Validating Nested Documents

CouchbaseOrm allows you to validate nested documents along with the parent document.

```ruby
class Address < CouchbaseOrm::NestedDocument
  attribute :street, :string
  attribute :city, :string
  attribute :country, :string

  validates :street, :city, :country, presence: true
end

class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :address, Address

  validates :address, presence: true
end
```

In this example, we define validations for the `Address` nested document, ensuring that the `street`, `city`, and `country` attributes are present. We also add a validation to the `User` model to ensure that the `address` attribute is present.

When saving a `User` document, CouchbaseOrm will validate both the parent document and the nested `Address` document. If any validation fails, the parent document will not be saved, and validation errors will be added to the parent document.

Nested documents provide a powerful way to model complex data structures and relationships within a single Couchbase document. They allow you to store related data together, improving performance and reducing the need for separate queries to retrieve associated data.

However, it's important to consider the trade-offs when using nested documents. Embedding too much data within a single document can lead to large document sizes and potential performance issues. It's recommended to use nested documents judiciously and to consider the access patterns and data relationships of your application.

In the next section, we'll explore enums in CouchbaseOrm and how they can be used to define a fixed set of values for an attribute.
