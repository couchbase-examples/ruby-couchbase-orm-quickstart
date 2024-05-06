# Advanced Topics

In this section, we'll explore some advanced topics in CouchbaseOrm, including transactions, concurrency, error handling, and extending CouchbaseOrm.

## 14.1. Transactions

Transactions allow you to group multiple database operations into a single atomic unit of work. If any operation within the transaction fails, all the changes made within the transaction are rolled back, ensuring data integrity and consistency.

CouchbaseOrm supports transactions through the `CouchbaseOrm.transaction` method. Here's an example of using transactions:

```ruby
CouchbaseOrm.transaction do
  user = User.create(name: 'John Doe', email: 'john@example.com')
  account = Account.create(user: user, balance: 100)
  # ...
end
```

In this example, the creation of a user and an account are wrapped inside a transaction. If any operation within the transaction fails, all the changes made within the transaction will be rolled back, ensuring that the database remains in a consistent state.

Transactions are useful when you need to perform multiple related operations that should succeed or fail together, such as creating related records or updating multiple documents atomically.

## 14.2. Concurrency

Concurrency refers to the ability of multiple processes or threads to access and manipulate data simultaneously. When working with a distributed database like Couchbase, it's important to consider concurrency and handle potential conflicts.

CouchbaseOrm provides several mechanisms to handle concurrency:

1. **Optimistic Locking**: CouchbaseOrm uses optimistic locking by default. Each document has a CAS (Compare and Swap) value that is checked during updates. If the CAS value has changed since the document was retrieved, indicating that another process has modified the document, an exception is raised, and the update fails.

2. **Pessimistic Locking**: Pessimistic locking can be achieved by using the `with_lock` method. It ensures that a document is locked while being accessed, preventing other processes from modifying it until the lock is released.

   ```ruby
   user = User.with_lock.find('user_id')
   # Perform updates on the user
   user.save
   ```

3. **Atomic Operations**: CouchbaseOrm supports atomic operations, such as `increment`, `decrement`, and `touch`, which allow you to perform specific operations on a document without the need for explicit locking.

   ```ruby
   user = User.find('user_id')
   user.increment(:login_count)
   ```

When designing your application, consider the concurrency requirements and choose the appropriate locking and synchronization mechanisms to ensure data integrity and avoid conflicts.

## 14.3. Error Handling

Proper error handling is crucial for building robust and resilient applications. CouchbaseOrm provides a set of exception classes that you can catch and handle in your code.

Some common exceptions in CouchbaseOrm include:

- `CouchbaseOrm::Error::DocumentNotFound`: Raised when a requested document is not found in the database.
- `CouchbaseOrm::Error::DocumentInvalid`: Raised when a document fails validation before being saved.
- `CouchbaseOrm::Error::DocumentConflict`: Raised when there is a conflict during an update operation, indicating that the document has been modified by another process.

You can catch and handle these exceptions to provide appropriate error responses or perform alternative actions:

```ruby
begin
  user = User.find('non_existent_id')
rescue CouchbaseOrm::Error::DocumentNotFound
  # Handle the case when the user is not found
  # ...
end
```

It's important to handle exceptions gracefully, provide meaningful error messages to users, and log exceptions for debugging and monitoring purposes.

## 14.4. Extending CouchbaseOrm

CouchbaseOrm is designed to be extensible, allowing you to customize and extend its behavior to fit your application's specific needs.

Here are a few ways you can extend CouchbaseOrm:

1. **Custom Plugins**: You can create custom plugins to add new functionality or modify existing behavior in CouchbaseOrm. Plugins can be used to define new query methods, add custom validations, or integrate with external libraries.

   ```ruby
   module MyCustomPlugin
     module ClassMethods
       def by_email(email)
         where(email: email).first
       end
     end

     def self.included(base)
       base.extend ClassMethods
     end
   end

   class User < CouchbaseOrm::Base
     include MyCustomPlugin
   end
   ```

2. **Callbacks**: CouchbaseOrm provides a set of callbacks that you can use to hook into the lifecycle of your models. You can define custom callbacks to perform additional actions before or after certain events, such as saving or updating a document.

   ```ruby
   class User < CouchbaseOrm::Base
     before_save :encrypt_password

     private

     def encrypt_password
       self.password = encrypt(password) if password_changed?
     end
   end
   ```

3. **Inheritance and Mixins**: You can use inheritance and mixins to share common behavior across multiple models. By defining a base model or a mixin module, you can encapsulate reusable code and keep your models DRY.

   ```ruby
   module Timestamps
     def self.included(base)
       base.attribute :created_at, :datetime
       base.attribute :updated_at, :datetime

       base.before_create :set_created_at
       base.before_update :set_updated_at
     end

     private

     def set_created_at
       self.created_at = Time.now
     end

     def set_updated_at
       self.updated_at = Time.now
     end
   end

   class User < CouchbaseOrm::Base
     include Timestamps
   end
   ```

Extending CouchbaseOrm allows you to tailor it to your application's specific requirements and add custom functionality that aligns with your business logic.

Remember to keep your extensions modular, maintainable, and well-tested to ensure the stability and reliability of your application.

In the next section, we'll explore troubleshooting techniques and common issues that you may encounter while working with CouchbaseOrm.
