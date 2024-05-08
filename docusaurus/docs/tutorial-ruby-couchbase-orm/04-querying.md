---
sidebar_position: 04
---

# Querying

CouchbaseOrm provides a powerful and expressive query interface for retrieving data from Couchbase Server. With CouchbaseOrm, you can easily construct queries using a fluent and intuitive API that resembles the querying capabilities of ActiveRecord.

## 4.1. Finding Records

CouchbaseOrm offers various methods to find records based on different criteria. Here are some commonly used methods:

- `find`: Finds a record by its primary key (ID).
- `find_by`: Finds the first record that matches the specified attribute-value pair.
- `where`: Retrieves records that match the specified conditions.

Here are some examples of finding records:

```ruby
# Find a user by ID
user = User.find('user_id_123')

# Find the first user with a specific email
user = User.find_by(email: 'user@example.com')

# Find all active users
active_users = User.where(active: true)
```

## 4.2. Where Clauses

The `where` method allows you to specify conditions to filter the records based on attribute values. You can chain multiple `where` clauses together to build more complex queries.

```ruby
# Find users with a specific name and age greater than 25
users = User.where(name: 'John').where('age > ?', 25)

# Find users with an email ending with a specific domain
users = User.where('email LIKE ?', '%@example.com')
```

CouchbaseOrm supports various comparison operators and placeholders in the `where` clauses, such as `=`, `>`, `<`, `>=`, `<=`, `LIKE`, and more.

## 4.3. Ordering

You can specify the order in which the retrieved records should be sorted using the `order` method. Pass the attribute name and the desired sort direction (`:asc` for ascending, `:desc` for descending).

```ruby
# Find users ordered by name in ascending order
users = User.order(:name)

# Find users ordered by age in descending order
users = User.order(age: :desc)
```

You can also chain multiple `order` clauses to sort by multiple attributes.

## 4.4. Limit and Offset

<!-- TODO: Have to implement this -->

To limit the number of records returned or to skip a certain number of records, you can use the `limit` and `offset` methods.

```ruby
# Find the first 10 users
users = User.limit(10)

# Find users starting from the 11th record
users = User.offset(10)

# Find users starting from the 11th record and limit to 10 records
users = User.offset(10).limit(10)
```

## 4.5. Scopes

Scopes allow you to define reusable query snippets that can be chained with other query methods. Scopes are defined as class methods within your model.

```ruby
class User < CouchbaseOrm::Base
  scope :active, -> { where(active: true) }
  scope :adults, -> { where('age >= ?', 18) }
end

# Find active adult users
users = User.active.adults
```

Scopes provide a clean and DRY way to encapsulate commonly used query conditions.

## 4.6. Pluck

The `pluck` method allows you to retrieve specific attributes from the matched records instead of loading the entire objects. It returns an array of values for the specified attributes.

```ruby
# Retrieve the names of all users
names = User.pluck(:name)

# Retrieve the names and emails of active users
name_emails = User.active.pluck(:name, :email)
```

## 4.7. Destroy All

To delete multiple records that match specific conditions, you can use the `destroy_all` method.

```ruby
# Delete all inactive users
User.where(active: false).destroy_all
```

Be cautious when using `destroy_all` as it permanently deletes the matched records from the database.

These are just a few examples of the querying capabilities provided by CouchbaseOrm. You can combine these methods in various ways to construct complex and specific queries based on your application's requirements.

In the next section, we'll explore how to use CouchbaseOrm to create, update, and delete records in Couchbase Server.
