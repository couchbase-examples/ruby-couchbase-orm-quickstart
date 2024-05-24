# SQL++ (formerly N1QL) Queries 

CouchbaseOrm provides support for executing SQL++ queries directly from your Ruby code. SQL++ (or formerly N1QL,i.e. Non-First Normal Form Query Language) is a powerful query language that allows you to perform complex queries and aggregations on your Couchbase data.

## Defining SQL++ Queries

To define an SQL++ query in your model, you can use the `n1ql` macro provided by CouchbaseOrm. Here are a few examples:

```ruby
class N1QLTest < CouchbaseOrm::Base
  attribute :name, type: String
  attribute :lastname, type: String
  enum rating: %i[awesome good okay bad], default: :okay

  n1ql :by_custom_rating, emit_key: [:rating], query_fn: proc { |bucket, _values, options|
    cluster.query("SELECT raw meta().id FROM `#{bucket.name}` WHERE type = 'n1_ql_test' AND rating IN [1, 2] ORDER BY name ASC", options)
  }

  n1ql :by_name, emit_key: [:name]

  n1ql :by_lastname, emit_key: [:lastname]

  n1ql :by_rating_emit, emit_key: :rating

  n1ql :by_custom_rating_values, emit_key: [:rating], query_fn: proc { |bucket, values, options|
  cluster.query("SELECT raw meta().id FROM `#{bucket.name}` where type = 'n1_ql_test' AND rating IN #{quote(values[0])} ORDER BY name ASC", options)
}
  n1ql :by_rating_reverse, emit_key: :rating, custom_order: 'name DESC'

  n1ql :by_rating_without_docs, emit_key: :rating, include_docs: false

  index_n1ql :rating
end

```

In these examples:

- The `by_custom_rating` query selects the document IDs where the `type` is `'n1_ql_test'` and the `rating` is either 1 or 2, ordered by the `name` attribute in ascending order.

- The `by_name`, `by_lastname`, and `by_rating_emit` queries use the `emit_key` option to specify the attribute to be used as the key for the query.

- The `by_custom_rating_values` query demonstrates passing values to the query using placeholders (`$1`, `$2`, etc.) and the `quote` method to properly escape the values.

- The `by_rating_reverse` query uses the `custom_order` option to specify a custom ordering for the query results.

- The `by_rating_without_docs` query sets `include_docs` to `false` to retrieve only the document IDs without fetching the full documents.

- The `index_n1ql` macro is used to define an index on the `rating` attribute and generate a corresponding query method.

## Query Parameters

SQL++ queries often require parameters to be passed in order to filter or customize the results. CouchbaseOrm allows you to define queries with placeholders and provide the parameter values when executing the query.

```ruby
n1ql :by_custom_rating_values, emit_key: [:rating], query_fn: proc { |bucket, values, options|
  cluster.query("SELECT raw meta().id FROM `#{bucket.name}` where type = 'n1_ql_test' AND rating IN #{quote(values[0])} ORDER BY name ASC", options)
}
```

In this example, the `values` parameter represents an array of values passed to the query. The `quote` method is used to properly escape and format the values for use in the query.

## Executing SQL++ Queries

To execute an SQL++ query, you simply call the defined query method on your model class.

```ruby
docs = N1QLTest.by_custom_rating().collect { |ob| ob.name }
```

CouchbaseOrm automatically executes the SQL++ query and returns the result set, which you can then process as needed.

## Query Options

CouchbaseOrm provides various options to customize the execution of SQL++ queries. These options can be passed as a hash parameter to the query method.

```ruby
docs = N1QLTest.by_rating_reverse(key: 1)
```

<!-- Some commonly used query options include:

- `key`: Specifies the key value(s) to filter the results.
- `limit`: Specifies the maximum number of results to return.
- `offset`: Specifies the number of results to skip before starting to return results.
- `include_docs`: Specifies whether to include the full document content in the results.
- `scan_consistency`: Specifies the consistency level for the query (`request_plus` by default). -->

## Placeholder Values

In addition to using positional placeholders (`$1`, `$2`, etc.), CouchbaseOrm also supports named placeholders for better readability.

```ruby
n1ql :by_name_and_rating, "SELECT * FROM `#{bucket.name}` WHERE name = $name AND rating = $rating"

docs = N1QLTest.by_name_and_rating(name: 'John', rating: 'awesome')
```

In this example, the `$name` and `$rating` placeholders are used in the query, and the values are provided using a hash parameter with the corresponding keys.

## Query Result Processing

By default, CouchbaseOrm automatically maps the query result to instances of your model class. However, you can also process the query result manually if needed.

```ruby
n1ql :by_custom_rating, emit_key: [:rating], query_fn: proc { |bucket, _values, options|
  cluster.query("SELECT raw meta().id FROM `#{bucket.name}` WHERE type = 'n1_ql_test' AND rating IN [1, 2] ORDER BY name ASC", options)
}

n1ql :by_custom_rating_values, emit_key: [:rating], query_fn: proc { |bucket, values, options|
  cluster.query("SELECT raw meta().id FROM `#{bucket.name}` where type = 'n1_ql_test' AND rating IN #{quote(values[0])} ORDER BY name ASC", options)
}
```

In the above example, the `by_custom_rating` and `by_custom_rating_values` queries are executed, and the results are processed manually to extract the `name` attribute from each document.

```ruby
# Query by custom rating
docs = N1QLTest.by_custom_rating.collect { |ob| ob.name }
puts "By custom rating #{docs}"

# Query by custom rating values
docs = N1QLTest.by_custom_rating_values(key: [[1, 2]]).collect { |ob| ob.name }
puts "By custom rating values #{docs}"
```

In the above examples, the `collect` method is used to extract the `name` attribute from each document in the result set.

## Indexing for SQL++

To optimize the performance of SQL++ queries, it's important to create appropriate indexes on the fields used in the query conditions. Couchbase Server provides a way to create indexes using the Index service.

```ruby
# Query using index_n1ql
docs = N1QLTest.find_by_rating(2).collect { |ob| ob.name }
puts "By index_n1ql #{docs}"

# Query using index_n1ql
docs = N1QLTest.by_rating.to_a.collect { |ob| ob.name }
puts "By index_n1ql #{docs}"
```

In this example, indexes are defined on the `rating` attribute using the `index_n1ql` macro.

Indexing helps improve the efficiency of SQL++ queries by allowing Couchbase Server to quickly locate the relevant documents based on the indexed fields.

---

SQL++ queries in CouchbaseOrm provide a powerful and flexible way to retrieve data from Couchbase Server. By leveraging the expressive power of SQL++, you can perform complex queries, aggregations, and data manipulations directly from your Ruby code.

Remember to ensure that you have the necessary indexes created on the fields used in your queries for optimal performance. Additionally, consider the query consistency level and other options based on your application's requirements.

With CouchbaseOrm's SQL++ support, you can easily integrate advanced querying capabilities into your Ruby application, enabling you to retrieve and manipulate data stored in Couchbase Server efficiently.