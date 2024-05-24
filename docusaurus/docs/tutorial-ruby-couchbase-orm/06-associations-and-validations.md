# Associations and Validations

## 6. Associations

CouchbaseOrm provides a way to define and work with associations between models. Associations allow you to establish relationships between different entities in your application, making it easier to manage and query related data.

CouchbaseOrm supports several types of associations, including:

- One-to-One (belongs_to)
- One-to-Many (has_many)
- Many-to-Many (has_and_belongs_to_many)

## 6.1. Belongs To

The `belongs_to` association is used to define a one-to-one relationship between two models, where the model containing the association "belongs to" the other model.

In the belongs to, `class_name` is the name of the class that the association points to. `foreign_key` is the name of the field in the current model that references the associated model.

They are optional and will be inferred from the association name if not provided.

Class name follows Pascal case and foreign key follows snake case.

```ruby
class Teacher < CouchbaseOrm::Base
 ...
end
class Student < CouchbaseOrm::Base
  attribute :name, :string
  attribute :grade, :integer
  attribute :teacher_id, :string

  belongs_to :teacher, class_name: 'Teacher', foreign_key: :teacher_id

  validates_presence_of :name, :grade, :teacher_id
end

```

In this example, a `Student` belongs to a `Teacher`. CouchbaseOrm assumes that the `students` documents contain a `teacher_id` field that references the associated teacher document.


## 6.2. Has Many

The `has_many` association is used to define a one-to-many relationship between two models, where one model can have multiple associated records of another model.

```ruby
class Teacher < CouchbaseOrm::Base
  attribute :name, :string
  attribute :subject, :string

  has_many :students, class_name: 'Student', foreign_key: :teacher_id, type: :n1ql, dependent: :destroy

  validates_presence_of :name, :subject
end

class Student < CouchbaseOrm::Base
 ...
end

```

In this example, a `Teacher` has many `Student`s, and a `Student` belongs to a `Teacher`. CouchbaseOrm assumes that the `students` documents contain a `teacher_id` field that references the associated teacher document.

You can customize the foreign key and class name if needed:

```ruby
class Teacher < CouchbaseOrm::Base
  has_many :pupils, class_name: 'Student', foreign_key: 'teacher_id'
end
```

In the following example, we demonstrate how to work with associations in CouchbaseOrm:

```ruby
# Creating a new teacher
puts "\nCreating a new teacher..."
teacher1 = Teacher.create(name: 'Mr. Smith', subject: 'Mathematics')
puts teacher1.inspect

# Creating new students
puts "\nCreating new students..."
student1 = Student.create(name: 'John Doe', grade: 9, teacher_id: teacher1.id)
student2 = Student.create(name: 'Jane Roe', grade: 10, teacher_id: teacher1.id)
puts student1.inspect
puts student2.inspect

# Associating students with teacher
puts "\nAssociating students with teacher..."
puts "Teacher's students: #{teacher1.students.inspect}"

# Find a teacher by a student's teacher_id
puts "\nFinding a teacher by a student's teacher_id..."
found_teacher = Teacher.find(student1.teacher_id)
puts found_teacher.inspect

# List students of a teacher
puts "\nListing students of a teacher..."
teacher1.reload
teacher_students = teacher1.students
teacher_students.each { |student| puts student.inspect }
```

Output:

```plaintext
Creating a new teacher...
#<Teacher id: "teacher-1-tMsE-O9pZ", name: "Mr. Smith", subject: "Mathematics">

Creating new students...
#<Student id: "student-1-tMsE_0KJ~", teacher_id: "teacher-1-tMsE-O9pZ", name: "John Doe", grade: 9>
#<Student id: "student-1-tMsE_Pski", teacher_id: "teacher-1-tMsE-O9pZ", name: "Jane Roe", grade: 10>

Associating students with teacher...
Teacher's students: #<CouchbaseOrm::ResultsProxy:0x00007478a5145b08 @proxyfied=[#<Student id: "student-1-tMsE_0KJ~", teacher_id: "teacher-1-tMsE-O9pZ", name: "John Doe", grade: 9>, #<Student id: "student-1-tMsE_Pski", teacher_id: "teacher-1-tMsE-O9pZ", name: "Jane Roe", grade: 10>]>

Finding a teacher by a student's teacher_id...
#<Teacher id: "teacher-1-tMsE-O9pZ", name: "Mr. Smith", subject: "Mathematics">

Listing students of a teacher...
#<Student id: "student-1-tMsE_0KJ~", teacher_id: "teacher-1-tMsE-O9pZ", name: "John Doe", grade: 9>
#<Student id: "student-1-tMsE_Pski", teacher_id: "teacher-1-tMsE-O9pZ", name: "Jane Roe", grade: 10>
```

## 6.3. Has And Belongs To Many

The `has_and_belongs_to_many` association is used to define a many-to-many relationship between two models, where each model can have multiple associated records of the other model.

```ruby
class Publisher < CouchbaseOrm::Base
  attribute :name, :string
  has_and_belongs_to_many :magazines, join_class: 'PublishersMagazines'

  validates :name, presence: true
end

class Magazine < CouchbaseOrm::Base
  attribute :title, :string
  attribute :genre, :string
  has_and_belongs_to_many :publishers, join_class: 'PublishersMagazines'

  validates :title, presence: true
  validates :genre, presence: true
end

class PublishersMagazines < CouchbaseOrm::Base
  attribute :publisher_id, :string
  attribute :magazine_id, :string

  validates :publisher_id, presence: true
  validates :magazine_id, presence: true
end

```

In this example, a `Publisher` has and belongs to many `Magazine`s, and a `Magazine` has and belongs to many `Publisher`s. The `PublishersMagazines` class serves as the join class that connects the `Publisher` and `Magazine` models.

You can customize the association name, class name, and foreign key if needed:

```ruby
class Publisher < CouchbaseOrm::Base
  has_and_belongs_to_many :books, class_name: 'Book', join_table: 'publishers_books', foreign_key: 'publisher_id', association_foreign_key: 'book_id'
end
```

In the following example, we demonstrate how to work with many-to-many associations in CouchbaseOrm:

```ruby
# Create publishers
publisher1 = Publisher.create(name: 'Penguin Random House')
publisher2 = Publisher.create(name: 'Hearst Communications')

# Create magazines
magazine1 = Magazine.create(title: 'Vogue', genre: 'Fashion')
magazine2 = Magazine.create(title: 'National Geographic', genre: 'Science')

# Associate publishers with magazines
publisher1.magazines << magazine1
publisher2.magazines << magazine2

# Print publishers and their magazines
puts "Publishers:"
puts Publisher.all.map { |publisher| "#{publisher.name} (ID: #{publisher.id})" }

puts "\nMagazines:"
puts Magazine.all.map { |magazine| "#{magazine.title} (Genre: #{magazine.genre}) by #{magazine.publishers.map(&:name).join(', ')} (ID: #{magazine.id})" }

# print magazine and tojson
puts "\nMagazines:"
puts Magazine.all.map { |magazine| "#{magazine.to_json}" }
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


## 6.8. Validations on Associations

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

<!-- ## 6.9. Strict Loading

CouchbaseOrm provides a `strict_loading` option that allows you to control how associations are loaded. When `strict_loading` is enabled, associations are loaded eagerly when the parent record is loaded, reducing the number of queries needed to fetch associated records.

```ruby
class User < CouchbaseOrm::Base
  has_many :posts, strict_loading: true
end
``` -->

Now, let's move on to the next section, where we'll explore how to use N1QL queries in CouchbaseOrm for more advanced querying capabilities.
