---
sidebar_position: 07
---

# N1QL Queries

CouchbaseOrm provides support for executing N1QL queries directly from your Ruby code. N1QL (Non-First Normal Form Query Language) is a powerful query language that allows you to perform complex queries and aggregations on your Couchbase data.

## 7.1. Defining N1QL Queries

To define an N1QL query in your model, you can use the `n1ql` class method provided by CouchbaseOrm.

```ruby
class User < CouchbaseOrm::Base
  n1ql :find_by_email, 'SELECT * FROM users WHERE email = $1'
end
```

In this example, we define an N1QL query named `find_by_email` that selects all users with a specific email address. The `$1` placeholder represents a parameter that will be provided when executing the query.

## 7.2. Query Parameters

N1QL queries often require parameters to be passed in order to filter or customize the results. CouchbaseOrm allows you to define queries with placeholders and provide the parameter values when executing the query.

```ruby
class User < CouchbaseOrm::Base
  n1ql :find_by_name_and_age, 'SELECT * FROM users WHERE name = $1 AND age >= $2'
end

users = User.find_by_name_and_age('John', 25)
```

In this example, the `find_by_name_and_age` query takes two parameters: the name and the minimum age. The `$1` and `$2` placeholders represent these parameters, respectively. When executing the query, we provide the actual values for the name and age.

## 7.3. Executing N1QL Queries

To execute an N1QL query, you simply call the defined query method on your model class.

```ruby
users = User.find_by_email('john@example.com')
```

CouchbaseOrm automatically executes the N1QL query and returns the result set as an array of model instances.

## 7.4. Query Options

CouchbaseOrm provides various options to customize the execution of N1QL queries. These options can be passed as a hash parameter to the query method.

```ruby
users = User.find_by_name_and_age('John', 25, limit: 10, consistency: :eventual)
```

Some commonly used query options include:

- `limit`: Specifies the maximum number of results to return.
- `offset`: Specifies the number of results to skip before starting to return results.
- `order_by`: Specifies the attribute(s) to sort the results by.
- `consistency`: Specifies the consistency level for the query (`eventual` or `request_plus`).
- `timeout`: Specifies the timeout value for the query in milliseconds.

## 7.5. Placeholder Values

In addition to using positional placeholders (`$1`, `$2`, etc.), CouchbaseOrm also supports named placeholders for better readability.

```ruby
class User < CouchbaseOrm::Base
  n1ql :find_by_name, 'SELECT * FROM users WHERE name = $name'
end

users = User.find_by_name(name: 'John')
```

In this example, the `$name` placeholder is used in the query, and the value is provided using a hash parameter with the corresponding key.

## 7.6. Query Result Processing

By default, CouchbaseOrm automatically maps the query result to instances of your model class. However, you can also process the query result manually if needed.

```ruby
class User < CouchbaseOrm::Base
  n1ql :count_by_age, 'SELECT COUNT(*) AS count FROM users WHERE age >= $1'
end

result = User.count_by_age(18, raw: true)
count = result.first['count']
```

In this example, the `count_by_age` query returns the count of users above a certain age. By passing the `raw: true` option, CouchbaseOrm returns the raw query result instead of mapping it to model instances. We can then access the count value from the result hash.

## 7.7. Indexing for N1QL

To optimize the performance of N1QL queries, it's important to create appropriate indexes on the fields used in the query conditions. Couchbase Server provides a way to create indexes using the Index service.

```ruby
class User < CouchbaseOrm::Base
  index :email
  index :age
end
```

In this example, we define indexes on the `email` and `age` fields of the `User` model. CouchbaseOrm automatically creates these indexes in Couchbase Server when the application starts or when the `User.ensure_indexes!` method is called.

Indexing helps improve the efficiency of N1QL queries by allowing Couchbase Server to quickly locate the relevant documents based on the indexed fields.

N1QL queries in CouchbaseOrm provide a powerful and flexible way to retrieve data from Couchbase Server. By leveraging the expressive power of N1QL, you can perform complex queries, aggregations, and data manipulations directly from your Ruby code.

In the next section, we'll explore how to use views in CouchbaseOrm for data querying and indexing.
