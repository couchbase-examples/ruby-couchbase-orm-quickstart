---
sidebar_position: 03
---

# Defining Models

In CouchbaseOrm, models are defined as Ruby classes that inherit from `CouchbaseOrm::Base`. Each model represents a document type in Couchbase Server and encapsulates the data and behavior of the objects in your application.

## 3.1. Creating a Model

To create a model, define a new class that inherits from `CouchbaseOrm::Base`. For example, let's create a `User` model:

```ruby
class User < CouchbaseOrm::Base
end
```

By convention, CouchbaseOrm uses the underscored, pluralized name of the class as the document type in Couchbase Server. In this case, the document type for the `User` model would be `users`.

## 3.2. Attribute Types

CouchbaseOrm supports various attribute types to define the structure and types of your model's data. You can specify the attributes of your model using the `attribute` method.

Here's an example of defining attributes in the `User` model:

```ruby
class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :age, :integer
  attribute :active, :boolean
  attribute :created_at, :datetime
end
```

In this example, we define several attributes for the `User` model, each with a specific type. The supported attribute types in CouchbaseOrm include:

- `:string`: Represents a string value.
- `:integer`: Represents an integer value.
- `:float`: Represents a floating-point value.
- `:boolean`: Represents a boolean value.
- `:date`: Represents a date value.
- `:datetime`: Represents a date and time value.
- `:time`: Represents a time value.
- `:array`: Represents an array of values.
- `:hash`: Represents a hash (dictionary) of key-value pairs.
- `:binary`: Represents a binary data value.

CouchbaseOrm automatically handles the serialization and deserialization of these attribute types when storing and retrieving documents from Couchbase Server.

## 3.3. Attribute Options

In addition to specifying the attribute type, you can also provide additional options to customize the behavior of the attributes. Some commonly used options include:

- `default`: Specifies a default value for the attribute if no value is provided.
- `alias`: Defines an alternate name for the attribute in the document.
- `readonly`: Marks the attribute as read-only, preventing it from being modified.

Here's an example of using attribute options:

```ruby
class User < CouchbaseOrm::Base
  attribute :name, :string, default: 'Unknown'
  attribute :email, :string, alias: :contact_email
  attribute :age, :integer, readonly: true
end
```

In this example, the `name` attribute has a default value of `'Unknown'`, the `email` attribute is aliased as `contact_email` in the document, and the `age` attribute is marked as read-only.

## 3.4. Timestamps

CouchbaseOrm provides built-in support for timestamp attributes. By default, if you define attributes named `created_at` and `updated_at` with the `:datetime` type, CouchbaseOrm will automatically populate these attributes with the current date and time when a document is created or updated.

```ruby
class User < CouchbaseOrm::Base
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
```

With these timestamp attributes defined, CouchbaseOrm will manage them automatically whenever a document is persisted or updated.

## 3.5. Callbacks

CouchbaseOrm supports lifecycle callbacks that allow you to execute code at certain points in a document's lifecycle. Callbacks can be used to perform actions before or after specific events, such as saving or updating a document.

Here are some commonly used callbacks:

- `before_create`: Runs before a new document is created.
- `after_create`: Runs after a new document is created.
- `before_save`: Runs before a document is saved (either created or updated).
- `after_save`: Runs after a document is saved (either created or updated).
- `before_update`: Runs before an existing document is updated.
- `after_update`: Runs after an existing document is updated.
- `before_destroy`: Runs before a document is destroyed.
- `after_destroy`: Runs after a document is destroyed.

To define a callback, use the corresponding callback method and provide a block or method name to be executed. For example:

```ruby
class User < CouchbaseOrm::Base
  before_create :set_default_role

  def set_default_role
    self.role ||= 'user'
  end
end
```

In this example, the `set_default_role` method is defined as a `before_create` callback. It sets a default role for the user if no role is provided before creating a new document.

Callbacks allow you to encapsulate logic related to the document lifecycle and maintain a clean and organized codebase.

## 3.6. Validations

CouchbaseOrm includes built-in validation capabilities to ensure the integrity and validity of your data before persisting it to Couchbase Server. Validations help you enforce business rules and constraints on your models.

To define validations, use the `validates` method followed by the attribute name and the desired validation rules. For example:

```ruby
class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :age, :integer

  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :age, numericality: { greater_than_or_equal_to: 18 }
end
```

In this example, we define several validations for the `User` model:

- The `name` attribute must be present.
- The `email` attribute must match a specific format (a valid email address).
- The `age` attribute must be a number greater than or equal to 18.

CouchbaseOrm provides a wide range of built-in validation helpers, such as:

- `presence`: Ensures that the attribute is not blank.
- `uniqueness`: Ensures that the attribute value is unique among all documents.
- `format`: Validates the attribute value against a regular expression.
- `length`: Validates the length of the attribute value.
- `numericality`: Validates that the attribute value is a valid number.
- `inclusion`: Ensures that the attribute value is included in a given set.
- `exclusion`: Ensures that the attribute value is not included in a given set.

You can also define custom validation methods by adding methods to your model class and using the `validate` method to trigger them. For example:

```ruby
class User < CouchbaseOrm::Base
  validate :custom_validation

  def custom_validation
    if some_condition
      errors.add(:base, 'Custom validation failed')
    end
  end
end
```

In this example, the `custom_validation` method is called during the validation process, and if `some_condition` is met, an error is added to the model's `errors` collection.

Validations are automatically run when saving a document. If any validations fail, the save operation will be aborted, and the model's `errors` collection will contain the validation error messages.

By leveraging validations, you can ensure the quality and consistency of your data before it is persisted to Couchbase Server.

With the model definition covered, including attributes, callbacks, and validations, you're ready to start querying and persisting data using CouchbaseOrm. In the next section, we'll explore the querying capabilities of CouchbaseOrm and how to retrieve data from Couchbase Server efficiently.
