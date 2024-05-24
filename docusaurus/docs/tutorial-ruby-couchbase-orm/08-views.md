# Views

CouchbaseOrm provides support for using views to query and index your data. Views are a powerful feature of Couchbase Server that allow you to define custom map-reduce functions to extract, filter, and aggregate your data.

## 8.1. Defining Views

To define a view in your model, you can use the `view` class method provided by CouchbaseOrm.

```ruby
class User < CouchbaseOrm::Base
  view :by_email, "function(doc) { if (doc.type === 'user' && doc.email) { emit(doc.email, null); } }"
end
```

In this example, we define a view named `by_email` that indexes users by their email address. The view function checks if the document is of type `'user'` and has an `email` attribute. If so, it emits the email as the key and `null` as the value.

## 8.2. Querying Views

To query a view, you can use the view name as a method on your model class.

```ruby
users = User.by_email
```

This will execute the `by_email` view and return the results as an array of model instances.

You can also pass query options to the view:

```ruby
users = User.by_email(key: 'john@example.com', include_docs: true)
```

Some commonly used query options include:

- `key`: Specifies a specific key to match.
- `startkey` and `endkey`: Specifies a range of keys to match.
- `limit`: Specifies the maximum number of results to return.
- `skip`: Specifies the number of results to skip before starting to return results.
- `include_docs`: Specifies whether to include the full document content in the results.

## 8.3. View Options

When defining a view, you can specify additional options to control the behavior of the view.

```ruby
class User < CouchbaseOrm::Base
  view :by_created_at, "function(doc) { if (doc.type === 'user' && doc.created_at) { emit(doc.created_at, null); } }", reduce: "_count"
end
```

In this example, we define a view named `by_created_at` that indexes users by their creation date. We also specify a reduce function `"_count"` to count the number of users for each creation date.

Other commonly used view options include:

- `map`: Specifies the map function for the view.
- `reduce`: Specifies the reduce function for the view.
- `include_docs`: Specifies whether to include the full document content in the view results.

## 8.4. Indexing Views

CouchbaseOrm automatically indexes your views when the application starts or when the `Model.ensure_views!` method is called.

```ruby
User.ensure_views!
```

This ensures that the views defined in your models are created and indexed in Couchbase Server.

## 8.5. Querying with Keys

You can query a view by specifying specific keys or a range of keys.

```ruby
users = User.by_email(key: 'john@example.com')
users = User.by_created_at(startkey: Time.now - 1.day, endkey: Time.now)
```

In the first example, we query the `by_email` view with a specific key to find users with the email `'john@example.com'`.

In the second example, we query the `by_created_at` view with a range of keys to find users created within the last day.

## 8.6. Reducing Results

If your view includes a reduce function, you can retrieve the reduced results instead of the full result set.

```ruby
count = User.by_created_at(reduce: true)
```

In this example, we query the `by_created_at` view with the `reduce` option set to `true`. This returns the reduced result, which is the count of users for each creation date.

## 8.7. Querying with Pagination

CouchbaseOrm allows you to paginate through view results using the `limit` and `skip` options.

```ruby
page1 = User.by_created_at(limit: 10)
page2 = User.by_created_at(limit: 10, skip: 10)
```

In this example, we query the `by_created_at` view with a limit of 10 results per page. The first query retrieves the first page of results, and the second query retrieves the second page by skipping the first 10 results.

Views in CouchbaseOrm provide a flexible and efficient way to query and aggregate your data. By defining custom map-reduce functions, you can create indexes tailored to your specific querying needs.

It's important to design your views carefully, considering the querying patterns and performance requirements of your application. Proper indexing and querying can significantly improve the performance and scalability of your application.

In the next section, we'll explore how to work with nested documents in CouchbaseOrm, allowing you to model complex data structures within a single document.
