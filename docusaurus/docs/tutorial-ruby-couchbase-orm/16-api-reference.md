# API Reference

This section provides a comprehensive reference of the CouchbaseOrm API, including the main classes, methods, and options available in the library. Use this reference as a quick guide to understand the functionality and usage of different parts of CouchbaseOrm.

## 16.1. CouchbaseOrm::Base

`CouchbaseOrm::Base` is the base class that all CouchbaseOrm models inherit from. It provides the core functionality for defining attributes, querying, and persisting data.

### Attribute Definition

- `attribute(name, type, options = {})`: Defines an attribute for the model with the specified name, type, and options.
  - `name`: The name of the attribute.
  - `type`: The type of the attribute (e.g., `:string`, `:integer`, `:boolean`, `:datetime`).
  - `options`: Additional options for the attribute (e.g., `default: value`, `readonly: true`).

### Querying

- `find(id)`: Finds a document by its ID.
- `find_by(conditions)`: Finds the first document that matches the specified conditions.
- `where(conditions)`: Returns a query scope with the specified conditions.
- `order(attribute, direction = :asc)`: Returns a query scope with the specified order.
- `limit(value)`: Returns a query scope with the specified limit.
- `offset(value)`: Returns a query scope with the specified offset.
- `pluck(*attributes)`: Retrieves only the specified attributes from the documents.
- `all`: Returns all documents in the collection.

### Persistence

- `create(attributes)`: Creates a new document with the specified attributes.
- `update(attributes)`: Updates the document with the specified attributes.
- `save`: Saves the document to the database.
- `destroy`: Deletes the document from the database.
- `touch`: Updates the document's timestamp without modifying its attributes.
- `increment(attribute, value = 1)`: Increments the specified attribute by the given value.
- `decrement(attribute, value = 1)`: Decrements the specified attribute by the given value.

### Validation

- `validate`: Validates the document's attributes.
- `valid?`: Returns true if the document is valid.
- `errors`: Returns the validation errors.

### Callbacks

- `before_save(method)`: Defines a callback to be executed before saving the document.
- `after_save(method)`: Defines a callback to be executed after saving the document.
- `before_create(method)`: Defines a callback to be executed before creating the document.
- `after_create(method)`: Defines a callback to be executed after creating the document.
- `before_update(method)`: Defines a callback to be executed before updating the document.
- `after_update(method)`: Defines a callback to be executed after updating the document.
- `before_destroy(method)`: Defines a callback to be executed before destroying the document.
- `after_destroy(method)`: Defines a callback to be executed after destroying the document.

## 16.2. CouchbaseOrm::Relation

`CouchbaseOrm::Relation` represents a query scope and provides methods for building and executing queries.

- `where(conditions)`: Adds conditions to the query scope.
- `order(attribute, direction = :asc)`: Specifies the order for the query results.
- `limit(value)`: Limits the number of documents returned.
- `offset(value)`: Specifies the number of documents to skip.
- `pluck(*attributes)`: Retrieves only the specified attributes from the documents.
- `to_a`: Executes the query and returns the results as an array.
- `count`: Returns the count of documents matching the query.
- `exists?`: Returns true if any document matches the query.
- `update_all(attributes)`: Updates all documents matching the query with the specified attributes.
- `delete_all`: Deletes all documents matching the query.

## 16.3. CouchbaseOrm::Persistence

`CouchbaseOrm::Persistence` provides methods for persisting documents to the database.

- `save`: Saves the document to the database.
- `create(attributes)`: Creates a new document with the specified attributes.
- `update(attributes)`: Updates the document with the specified attributes.
- `delete`: Deletes the document from the database.
- `touch`: Updates the document's timestamp without modifying its attributes.

## 16.4. CouchbaseOrm::Associations

`CouchbaseOrm::Associations` provides methods for defining and working with associations between models.

- `belongs_to(name, options = {})`: Defines a belongs_to association.
- `has_many(name, options = {})`: Defines a has_many association.
- `has_one(name, options = {})`: Defines a has_one association.
- `build_association(name)`: Builds a new associated object.
- `create_association(name, attributes = {})`: Creates a new associated object with the specified attributes.
- `reload_association(name)`: Reloads the associated object(s) from the database.

## 16.5. CouchbaseOrm::N1ql

`CouchbaseOrm::N1ql` provides methods for executing N1QL queries.

- `n1ql(query, *params)`: Executes an N1QL query with the specified parameters.
- `find_by_n1ql(query, *params)`: Finds the first document that matches the N1QL query.
- `where_n1ql(query, *params)`: Returns a query scope with the specified N1QL query.

## 16.6. CouchbaseOrm::Views

`CouchbaseOrm::Views` provides methods for defining and querying views.

- `view(name, options = {})`: Defines a view with the specified name and options.
- `find_by_view(name, options = {})`: Finds documents using the specified view and options.
- `where_view(name, options = {})`: Returns a query scope using the specified view and options.

## 16.7. CouchbaseOrm::NestedDocument

`CouchbaseOrm::NestedDocument` represents an nested document within a parent document.

- `attribute(name, type, options = {})`: Defines an attribute for the nested document.
- `validate`: Validates the nested document's attributes.
- `valid?`: Returns true if the nested document is valid.
- `errors`: Returns the validation errors.

## 16.8. CouchbaseOrm::Enum

`CouchbaseOrm::Enum` provides methods for defining and working with enums.

- `enum(attribute, values, options = {})`: Defines an enum attribute with the specified values and options.
- `<attribute>_before_type_cast`: Returns the enum value before type casting.
- `<attribute>_values`: Returns an array of valid enum values.

## 16.9. CouchbaseOrm::Encrypt

`CouchbaseOrm::Encrypt` provides methods for encrypting and decrypting attributes.

- `attribute(name, type, options = {})`: Defines an attribute with encryption options.
- `encrypted_<attribute>`: Returns the encrypted value of the attribute.
- `encrypted_<attribute>=(value)`: Sets the encrypted value of the attribute.

## 16.10. CouchbaseOrm::Utilities

`CouchbaseOrm::Utilities` provides utility methods for working with CouchbaseOrm.

- `CouchbaseOrm.connection`: Returns the Couchbase connection.
- `CouchbaseOrm.bucket`: Returns the Couchbase bucket.
- `CouchbaseOrm.configuration`: Returns the CouchbaseOrm configuration.
- `CouchbaseOrm.logger`: Returns the CouchbaseOrm logger.

This API reference provides an overview of the main classes, methods, and options available in CouchbaseOrm. Refer to the specific class documentation for more detailed information on each method's parameters, return values, and usage examples.

Remember to consult the CouchbaseOrm documentation and guides for more comprehensive explanations and best practices when using the library.
