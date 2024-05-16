"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[80],{4131:(e,s,n)=>{n.r(s),n.d(s,{assets:()=>c,contentTitle:()=>t,default:()=>h,frontMatter:()=>i,metadata:()=>r,toc:()=>d});var a=n(4848),o=n(8453);const i={sidebar_position:6},t="Associations and Validations",r={id:"tutorial-ruby-couchbase-orm/associations-and-validations",title:"Associations and Validations",description:"6. Associations",source:"@site/docs/tutorial-ruby-couchbase-orm/06-associations-and-validations.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/associations-and-validations",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/associations-and-validations",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/06-associations-and-validations.md",tags:[],version:"current",sidebarPosition:6,frontMatter:{sidebar_position:6},sidebar:"tutorialSidebar",previous:{title:"Persistence",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/persistence"},next:{title:"N1QL Queries",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/n1ql-queries"}},c={},d=[{value:"6. Associations",id:"6-associations",level:2},{value:"6.1. Belongs To",id:"61-belongs-to",level:2},{value:"6.2. Has Many",id:"62-has-many",level:2},{value:"6.3. Has And Belongs To Many",id:"63-has-and-belongs-to-many",level:2},{value:"6.4. Polymorphic Associations",id:"64-polymorphic-associations",level:2},{value:"6.5. Dependent Associations",id:"65-dependent-associations",level:2},{value:"6.6. Autosave",id:"66-autosave",level:2},{value:"6.7. Querying Associations",id:"67-querying-associations",level:2},{value:"6.8. Eager Loading",id:"68-eager-loading",level:2},{value:"6.9. Validations",id:"69-validations",level:2}];function l(e){const s={code:"code",h1:"h1",h2:"h2",li:"li",p:"p",pre:"pre",ul:"ul",...(0,o.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(s.h1,{id:"associations-and-validations",children:"Associations and Validations"}),"\n",(0,a.jsx)(s.h2,{id:"6-associations",children:"6. Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm provides a way to define and work with associations between models. Associations allow you to establish relationships between different entities in your application, making it easier to manage and query related data."}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm supports several types of associations, including:"}),"\n",(0,a.jsxs)(s.ul,{children:["\n",(0,a.jsx)(s.li,{children:"One-to-One (belongs_to)"}),"\n",(0,a.jsx)(s.li,{children:"One-to-Many (has_many)"}),"\n",(0,a.jsx)(s.li,{children:"Many-to-Many (has_and_belongs_to_many)"}),"\n"]}),"\n",(0,a.jsx)(s.h2,{id:"61-belongs-to",children:"6.1. Belongs To"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"belongs_to"}),' association is used to define a one-to-one relationship between two models, where the model containing the association "belongs to" the other model.']}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Post < CouchbaseOrm::Base\n  belongs_to :user\nend\n\nclass User < CouchbaseOrm::Base\n  # ...\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Post"})," belongs to a ",(0,a.jsx)(s.code,{children:"User"}),". CouchbaseOrm assumes that the ",(0,a.jsx)(s.code,{children:"posts"})," document contains a ",(0,a.jsx)(s.code,{children:"user_id"})," field that references the associated user document."]}),"\n",(0,a.jsx)(s.p,{children:"You can customize the foreign key and class name if needed:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Post < CouchbaseOrm::Base\n  belongs_to :author, class_name: 'User', foreign_key: 'author_id'\nend\n"})}),"\n",(0,a.jsx)(s.h2,{id:"62-has-many",children:"6.2. Has Many"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"has_many"})," association is used to define a one-to-many relationship between two models, where one model can have multiple associated records of another model."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts\nend\n\nclass Post < CouchbaseOrm::Base\n  # ...\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"User"})," has many ",(0,a.jsx)(s.code,{children:"Post"}),"s. CouchbaseOrm assumes that the ",(0,a.jsx)(s.code,{children:"posts"})," documents contain a ",(0,a.jsx)(s.code,{children:"user_id"})," field that references the associated user document."]}),"\n",(0,a.jsx)(s.p,{children:"You can customize the foreign key and class name if needed:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :articles, class_name: 'Post', foreign_key: 'author_id'\nend\n"})}),"\n",(0,a.jsx)(s.h2,{id:"63-has-and-belongs-to-many",children:"6.3. Has And Belongs To Many"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"has_and_belongs_to_many"})," association is used to define a many-to-many relationship between two models, where each model can have multiple associated records of the other model."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Student < CouchbaseOrm::Base\n  has_and_belongs_to_many :courses\nend\n\nclass Course < CouchbaseOrm::Base\n  has_and_belongs_to_many :students\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Student"})," has and belongs to many ",(0,a.jsx)(s.code,{children:"Course"}),"s, and a ",(0,a.jsx)(s.code,{children:"Course"})," has and belongs to many ",(0,a.jsx)(s.code,{children:"Student"}),"s. CouchbaseOrm assumes that there is an intermediate document type (e.g., ",(0,a.jsx)(s.code,{children:"enrollments"}),") that stores the associations between students and courses."]}),"\n",(0,a.jsx)(s.p,{children:"You can customize the association name, class name, and foreign key if needed:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Student < CouchbaseOrm::Base\n  has_and_belongs_to_many :enrolled_courses, class_name: 'Course', foreign_key: 'student_ids'\nend\n"})}),"\n",(0,a.jsx)(s.h2,{id:"64-polymorphic-associations",children:"6.4. Polymorphic Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm supports polymorphic associations, which allow a model to belong to multiple other models through a single association."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Comment < CouchbaseOrm::Base\n  belongs_to :commentable, polymorphic: true\nend\n\nclass Post < CouchbaseOrm::Base\n  has_many :comments, as: :commentable\nend\n\nclass Photo < CouchbaseOrm::Base\n  has_many :comments, as: :commentable\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Comment"})," can belong to either a ",(0,a.jsx)(s.code,{children:"Post"})," or a ",(0,a.jsx)(s.code,{children:"Photo"})," through the ",(0,a.jsx)(s.code,{children:"commentable"})," association. The ",(0,a.jsx)(s.code,{children:"commentable_type"})," field in the ",(0,a.jsx)(s.code,{children:"comments"})," document stores the type of the associated record (",(0,a.jsx)(s.code,{children:"Post"})," or ",(0,a.jsx)(s.code,{children:"Photo"}),"), and the ",(0,a.jsx)(s.code,{children:"commentable_id"})," field stores the ID of the associated record."]}),"\n",(0,a.jsx)(s.h2,{id:"65-dependent-associations",children:"6.5. Dependent Associations"}),"\n",(0,a.jsxs)(s.p,{children:["CouchbaseOrm allows you to specify what should happen to associated records when the parent record is destroyed. You can use the ",(0,a.jsx)(s.code,{children:"dependent"})," option to control this behavior."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts, dependent: :destroy\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, when a ",(0,a.jsx)(s.code,{children:"User"})," is destroyed, all associated ",(0,a.jsx)(s.code,{children:"Post"}),"s will also be destroyed. Other options for ",(0,a.jsx)(s.code,{children:"dependent"})," include ",(0,a.jsx)(s.code,{children:":nullify"})," (sets the foreign key to null), ",(0,a.jsx)(s.code,{children:":restrict_with_exception"})," (raises an exception if there are associated records), and ",(0,a.jsx)(s.code,{children:":delete_all"})," (deletes associated records without running callbacks)."]}),"\n",(0,a.jsx)(s.h2,{id:"66-autosave",children:"6.6. Autosave"}),"\n",(0,a.jsxs)(s.p,{children:["CouchbaseOrm provides an ",(0,a.jsx)(s.code,{children:"autosave"})," option that automatically saves associated records when saving the parent record."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts, autosave: true\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["With ",(0,a.jsx)(s.code,{children:"autosave"})," set to ",(0,a.jsx)(s.code,{children:"true"}),", saving a ",(0,a.jsx)(s.code,{children:"User"})," will also save any new or modified associated ",(0,a.jsx)(s.code,{children:"Post"}),"s."]}),"\n",(0,a.jsx)(s.h2,{id:"67-querying-associations",children:"6.7. Querying Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm allows you to easily query and retrieve associated records using the defined associations."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"user = User.find('user_id_123')\nposts = user.posts\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, ",(0,a.jsx)(s.code,{children:"user.posts"})," retrieves all the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s for the given ",(0,a.jsx)(s.code,{children:"User"}),"."]}),"\n",(0,a.jsx)(s.p,{children:"You can also chain query methods on associations:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"recent_posts = user.posts.where('created_at >= ?', 1.week.ago).order(created_at: :desc)\n"})}),"\n",(0,a.jsxs)(s.p,{children:["This query retrieves the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s for the user that were created within the last week, ordered by the most recent first."]}),"\n",(0,a.jsx)(s.h2,{id:"68-eager-loading",children:"6.8. Eager Loading"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm supports eager loading of associations to avoid the N+1 query problem. Eager loading allows you to retrieve associated records along with the parent records in a single query, improving performance."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"users = User.where(active: true).includes(:posts)\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, the ",(0,a.jsx)(s.code,{children:"includes"})," method eagerly loads the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s for the retrieved ",(0,a.jsx)(s.code,{children:"User"}),"s, minimizing the number of database queries."]}),"\n",(0,a.jsx)(s.p,{children:"Associations in CouchbaseOrm provide a powerful way to model and work with relationships between your application's entities. By defining associations, you can easily navigate and query related data, making your code more expressive and efficient."}),"\n",(0,a.jsx)(s.h2,{id:"69-validations",children:"6.9. Validations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm allows you to validate associated records when saving the parent record. This ensures that the associated records are valid before persisting them to the database."}),"\n",(0,a.jsxs)(s.p,{children:["You can use the ",(0,a.jsx)(s.code,{children:"validates_associated"})," method to validate associated records:"]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts\n  validates_associated :posts\nend\n\nclass Post < CouchbaseOrm::Base\n  belongs_to :user\n  validates :title, presence: true\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, when saving a ",(0,a.jsx)(s.code,{children:"User"}),", CouchbaseOrm will also validate the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s. If any of the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s fail validation, the parent ",(0,a.jsx)(s.code,{children:"User"})," will not be saved, and validation errors will be added to the parent record."]}),"\n",(0,a.jsx)(s.p,{children:"You can also specify the validation context for associated records:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts\n  validates_associated :posts, on: :create\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this case, the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s will only be validated when creating a new ",(0,a.jsx)(s.code,{children:"User"}),", not when updating an existing one."]}),"\n",(0,a.jsxs)(s.p,{children:["By using ",(0,a.jsx)(s.code,{children:"validates_associated"}),", you can ensure that the entire object graph is valid before saving the parent record, maintaining data integrity and consistency."]}),"\n",(0,a.jsx)(s.p,{children:"N1QL queries in CouchbaseOrm provide a powerful and flexible way to retrieve data from Couchbase Server. By leveraging the expressive power of N1QL, you can perform complex queries, aggregations, and data manipulations directly from your Ruby code."}),"\n",(0,a.jsx)(s.p,{children:"Now, let's move on to the next section, where we'll explore how to use N1QL queries in CouchbaseOrm for more advanced querying capabilities."})]})}function h(e={}){const{wrapper:s}={...(0,o.R)(),...e.components};return s?(0,a.jsx)(s,{...e,children:(0,a.jsx)(l,{...e})}):l(e)}},8453:(e,s,n)=>{n.d(s,{R:()=>t,x:()=>r});var a=n(6540);const o={},i=a.createContext(o);function t(e){const s=a.useContext(i);return a.useMemo((function(){return"function"==typeof e?e(s):{...s,...e}}),[s,e])}function r(e){let s;return s=e.disableParentContext?"function"==typeof e.components?e.components(o):e.components||o:t(e.components),a.createElement(i.Provider,{value:s},e.children)}}}]);