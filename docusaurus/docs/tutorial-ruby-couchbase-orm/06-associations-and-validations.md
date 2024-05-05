---
sidebar_position: 06
---

# Associations and Validations

## 6. Associations

CouchbaseOrm provides a way to define and work with associations between models. Associations allow you to establish relationships between different entities in your application, making it easier to manage and query related data.

CouchbaseOrm supports several types of associations, including:

- One-to-One (belongs_to)
- One-to-Many (has_many)
- Many-to-Many (has_and_belongs_to_many)

## 6.1. Belongs To

The `belongs_to` association is used to define a one-to-one relationship between two models, where the model containing the association "belongs to" the other model.

```ruby
class Post < CouchbaseOrm::Base
  belongs_to :user
end

class User < CouchbaseOrm::Base
  # ...
end
```

In this example, a `Post` belongs to a `User`. CouchbaseOrm assumes that the `posts` document contains a `user_id` field that references the associated user document.

You can customize the foreign key and class name if needed:

```ruby
class Post < CouchbaseOrm::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
end
```

## 6.2. Has Many

The `has_many` association is used to define a one-to-many relationship between two models, where one model can have multiple associated records of another model.

```ruby
class User < CouchbaseOrm::Base
  has_many :posts
end

class Post < CouchbaseOrm::Base
  # ...
end
```

In this example, a `User` has many `Post`s. CouchbaseOrm assumes that the `posts` documents contain a `user_id` field that references the associated user document.

You can customize the foreign key and class name if needed:

```ruby
class User < CouchbaseOrm::Base
  has_many :articles, class_name: 'Post', foreign_key: 'author_id'
end
```

## 6.3. Has And Belongs To Many

The `has_and_belongs_to_many` association is used to define a many-to-many relationship between two models, where each model can have multiple associated records of the other model.

```ruby
class Student < CouchbaseOrm::Base
  has_and_belongs_to_many :courses
end

class Course < CouchbaseOrm::Base
  has_and_belongs_to_many :students
end
```

In this example, a `Student` has and belongs to many `Course`s, and a `Course` has and belongs to many `Student`s. CouchbaseOrm assumes that there is an intermediate document type (e.g., `enrollments`) that stores the associations between students and courses.

You can customize the association name, class name, and foreign key if needed:

```ruby
class Student < CouchbaseOrm::Base
  has_and_belongs_to_many :enrolled_courses, class_name: 'Course', foreign_key: 'student_ids'
end
```

## 6.4. Polymorphic Associations

CouchbaseOrm supports polymorphic associations, which allow a model to belong to multiple other models through a single association.

```ruby
class Comment < CouchbaseOrm::Base
  belongs_to :commentable, polymorphic: true
end

class Post < CouchbaseOrm::Base
  has_many :comments, as: :commentable
end

class Photo < CouchbaseOrm::Base
  has_many :comments, as: :commentable
end
```

In this example, a `Comment` can belong to either a `Post` or a `Photo` through the `commentable` association. The `commentable_type` field in the `comments` document stores the type of the associated record (`Post` or `Photo`), and the `commentable_id` field stores the ID of the associated record.

## 6.5. Dependent Associations

CouchbaseOrm allows you to specify what should happen to associated records when the parent record is destroyed. You can use the `dependent` option to control this behavior.

```ruby
class User < CouchbaseOrm::Base
  has_many :posts, dependent: :destroy
end
```

In this example, when a `User` is destroyed, all associated `Post`s will also be destroyed. Other options for `dependent` include `:nullify` (sets the foreign key to null), `:restrict_with_exception` (raises an exception if there are associated records), and `:delete_all` (deletes associated records without running callbacks).

## 6.6. Autosave

CouchbaseOrm provides an `autosave` option that automatically saves associated records when saving the parent record.

```ruby
class User < CouchbaseOrm::Base
  has_many :posts, autosave: true
end
```

With `autosave` set to `true`, saving a `User` will also save any new or modified associated `Post`s.

## 6.7. Querying Associations

CouchbaseOrm allows you to easily query and retrieve associated records using the defined associations.

```ruby
user = User.find('user_id_123')
posts = user.posts
```

In this example, `user.posts` retrieves all the associated `Post`s for the given `User`.

You can also chain query methods on associations:

```ruby
recent_posts = user.posts.where('created_at >= ?', 1.week.ago).order(created_at: :desc)
```

This query retrieves the associated `Post`s for the user that were created within the last week, ordered by the most recent first.

## 6.8. Eager Loading

CouchbaseOrm supports eager loading of associations to avoid the N+1 query problem. Eager loading allows you to retrieve associated records along with the parent records in a single query, improving performance.

```ruby
users = User.where(active: true).includes(:posts)
```

In this example, the `includes` method eagerly loads the associated `Post`s for the retrieved `User`s, minimizing the number of database queries.

Associations in CouchbaseOrm provide a powerful way to model and work with relationships between your application's entities. By defining associations, you can easily navigate and query related data, making your code more expressive and efficient.

## 6.9. Validations

CouchbaseOrm allows you to validate associated records when saving the parent record. This ensures that the associated records are valid before persisting them to the database.

You can use the `validates_associated` method to validate associated records:

```ruby
class User < CouchbaseOrm::Base
  has_many :posts
  validates_associated :posts
end

class Post < CouchbaseOrm::Base
  belongs_to :user
  validates :title, presence: true
end
```

In this example, when saving a `User`, CouchbaseOrm will also validate the associated `Post`s. If any of the associated `Post`s fail validation, the parent `User` will not be saved, and validation errors will be added to the parent record.

You can also specify the validation context for associated records:

```ruby
class User < CouchbaseOrm::Base
  has_many :posts
  validates_associated :posts, on: :create
end
```

In this case, the associated `Post`s will only be validated when creating a new `User`, not when updating an existing one.

By using `validates_associated`, you can ensure that the entire object graph is valid before saving the parent record, maintaining data integrity and consistency.

N1QL queries in CouchbaseOrm provide a powerful and flexible way to retrieve data from Couchbase Server. By leveraging the expressive power of N1QL, you can perform complex queries, aggregations, and data manipulations directly from your Ruby code.

Now, let's move on to the next section, where we'll explore how to use N1QL queries in CouchbaseOrm for more advanced querying capabilities.
