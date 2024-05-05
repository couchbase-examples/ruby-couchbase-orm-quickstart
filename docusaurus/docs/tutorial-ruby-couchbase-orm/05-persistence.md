---
sidebar_position: 05
---

# Persistence

CouchbaseOrm provides a simple and intuitive way to persist data to Couchbase Server. With CouchbaseOrm, you can easily create, update, save, and destroy records using a set of built-in methods.

## 5.1. Creating Records

To create a new record, you can instantiate a new instance of your model class and then call the `save` method to persist it to the database.

```ruby
user = User.new(name: 'John', email: 'john@example.com')
user.save
```

Alternatively, you can use the `create` method to create a new record in a single step:

```ruby
user = User.create(name: 'John', email: 'john@example.com')
```

The `create` method instantiates a new instance of the model, sets the attributes, and saves it to the database.

## 5.2. Updating Records

To update an existing record, you can modify its attributes and then call the `save` method to persist the changes.

```ruby
user = User.find('user_id_123')
user.name = 'John Doe'
user.save
```

CouchbaseOrm automatically tracks the changes made to the attributes and updates only the modified fields in the database.

## 5.3. Saving Records

The `save` method is used to persist a record to the database, whether it's a new record or an existing one with modifications.

```ruby
user = User.new(name: 'John')
user.save # Creates a new record

user.name = 'John Doe'
user.save # Updates the existing record
```

If the record is new (i.e., it doesn't have an ID), `save` will create a new document in Couchbase Server. If the record already exists, `save` will update the existing document with the modified attributes.

## 5.4. Destroying Records

To delete a record from the database, you can call the `destroy` method on an instance of your model.

```ruby
user = User.find('user_id_123')
user.destroy
```

The `destroy` method removes the corresponding document from Couchbase Server and freezes the model instance to prevent further modifications.

## 5.5. Updating Specific Fields

CouchbaseOrm provides a way to update specific fields of a record without retrieving the entire document from the database. This can be useful for performance optimization when you only need to update a subset of attributes.

```ruby
user = User.find('user_id_123')
user.update(name: 'John Doe', age: 30)
```

The `update` method updates only the specified attributes of the record in the database.

## 5.6. Atomic Operations

CouchbaseOrm supports atomic operations, which allow you to perform certain database operations in a single, indivisible step. Atomic operations ensure data consistency and help avoid race conditions in concurrent environments.

Some common atomic operations include:

- `increment`: Atomically increments a numeric attribute by a specified value.
- `decrement`: Atomically decrements a numeric attribute by a specified value.
- `append`: Atomically appends a value to a string attribute.
- `prepend`: Atomically prepends a value to a string attribute.
- `touch`: Updates the document's expiration time without modifying its content.

Here's an example of using atomic operations:

```ruby
user = User.find('user_id_123')
user.increment(:login_count)
user.touch(expiry: 1.hour.from_now)
```

In this example, the `increment` operation atomically increments the `login_count` attribute of the user, and the `touch` operation updates the document's expiration time to one hour from now.

## 5.7. Callbacks

As mentioned in the previous section on defining models, CouchbaseOrm supports lifecycle callbacks that allow you to execute code at certain points in a record's persistence lifecycle.

Callbacks can be used to perform actions before or after specific events, such as saving or updating a record. Some commonly used callbacks include `before_save`, `after_save`, `before_create`, `after_create`, `before_update`, `after_update`, `before_destroy`, and `after_destroy`.

```ruby
class User < CouchbaseOrm::Base
  before_save :encrypt_password
  after_create :send_welcome_email

  private

  def encrypt_password
    self.password = encrypt(password) if password_changed?
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
```

In this example, the `encrypt_password` callback is executed before saving a user record, encrypting the password if it has been changed. The `send_welcome_email` callback is executed after creating a new user record, sending a welcome email to the user.

Callbacks provide a way to encapsulate and reuse common logic related to the persistence lifecycle of your records.

## 5.8. Transactions

CouchbaseOrm supports transactions, which allow you to group multiple database operations into a single, atomic unit of work. Transactions ensure that all the operations within the transaction either succeed together or fail together, maintaining data integrity.

```ruby
CouchbaseOrm.transaction do
  user = User.create(name: 'John')
  account = Account.create(user: user, balance: 100)
  # ...
end
```

In this example, the creation of a user and an associated account are wrapped inside a transaction. If any operation within the transaction fails, all the changes made within the transaction will be rolled back, ensuring that the database remains in a consistent state.

Transactions are useful when you need to perform multiple related operations that should succeed or fail together, such as creating related records or updating multiple documents atomically.

That covers the basics of persistence with CouchbaseOrm. With these methods and features, you can easily create, update, delete, and manipulate records in Couchbase Server using a simple and expressive API.

In the next section, we'll explore the powerful associations feature of CouchbaseOrm, which allows you to define and work with relationships between your models.
