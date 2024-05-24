# Views (aka Map/Reduce indexes)

Views are defined in the model and typically just emit an attribute that
can then be used for filtering results or ordering.

```ruby
    class Comment < CouchbaseOrm::Base
      attribute :author :string
      attribute :body, :string
      view :all # => emits :id and will return all comments
      view :by_author, emit_key: :author

      # Generates two functions:
      # * the by_author view above
      # * def find_by_author(author); end
      index_view :author

      # You can make compound keys by passing an array to :emit_key
      # this allow to query by read/unread comments
      view :by_read, emit_key: [:user_id, :read]
      # this allow to query by view_count
      view :by_view_count, emit_key: [:user_id, :view_count]

      validates_presence_of :author, :body
    end
```

You can use `Comment.find_by_author('name')` to obtain all the comments by
a particular author. The same thing, using the view directly would be:
`Comment.by_author(key: 'name')`

When using a compound key, the usage is the same, you just give the full key :

```ruby
   Comment.by_read(key: '["'+user_id+'",false]') # gives all unread comments for one particular user

   # or even a range !

   Comment.by_view_count(startkey: '["'+user_id+'",10]', endkey: '["'+user_id+'",20]') 
   
   # gives all comments that have been seen more than 10 times but less than 20
```

Ex : Compound keys allows to decide the order of the results, and you can reverse it by passing `descending: true`

```ruby
    class Comment < CouchbaseOrm::Base19
      self.ignored_properties = [:old_name] # ignore old_name property in the model
      self.properties_always_exists_in_document = true # use is null for nil value instead of not valued for performance purpose, only possible if all properties always exists in document
    end
```      
You can specify `properties_always_exists_in_document` to true if all properties always exists in document, this will allow to use `is null` instead of `not valued` for nil value, this will improve performance. 

WARNING: If a document exists without a property, the query will failed! So you must be sure that all documents have all properties.