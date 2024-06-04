"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[80],{4348:(e,s,n)=>{n.r(s),n.d(s,{assets:()=>c,contentTitle:()=>o,default:()=>h,frontMatter:()=>i,metadata:()=>r,toc:()=>d});var a=n(4848),t=n(8453);const i={},o="Associations and Validations",r={id:"tutorial-ruby-couchbase-orm/associations-and-validations",title:"Associations and Validations",description:"6. Associations",source:"@site/docs/tutorial-ruby-couchbase-orm/06-associations-and-validations.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/associations-and-validations",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/associations-and-validations",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/06-associations-and-validations.md",tags:[],version:"current",sidebarPosition:6,frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Persistence",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/persistence"},next:{title:"SQL++ (formerly N1QL) Queries",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/sqlpp-queries"}},c={},d=[{value:"6. Associations",id:"6-associations",level:2},{value:"6.1. Belongs To",id:"61-belongs-to",level:2},{value:"6.2. Has Many",id:"62-has-many",level:2},{value:"6.3. Has And Belongs To Many",id:"63-has-and-belongs-to-many",level:2},{value:"6.4. Polymorphic Associations",id:"64-polymorphic-associations",level:2},{value:"6.5. Dependent Associations",id:"65-dependent-associations",level:2},{value:"6.6. Autosave",id:"66-autosave",level:2},{value:"6.7. Querying Associations",id:"67-querying-associations",level:2}];function l(e){const s={code:"code",h1:"h1",h2:"h2",li:"li",p:"p",pre:"pre",ul:"ul",...(0,t.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(s.h1,{id:"associations-and-validations",children:"Associations and Validations"}),"\n",(0,a.jsx)(s.h2,{id:"6-associations",children:"6. Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm provides a way to define and work with associations between models. Associations allow you to establish relationships between different entities in your application, making it easier to manage and query related data."}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm supports several types of associations, including:"}),"\n",(0,a.jsxs)(s.ul,{children:["\n",(0,a.jsx)(s.li,{children:"One-to-One (belongs_to)"}),"\n",(0,a.jsx)(s.li,{children:"One-to-Many (has_many)"}),"\n",(0,a.jsx)(s.li,{children:"Many-to-Many (has_and_belongs_to_many)"}),"\n"]}),"\n",(0,a.jsx)(s.h2,{id:"61-belongs-to",children:"6.1. Belongs To"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"belongs_to"}),' association is used to define a one-to-one relationship between two models, where the model containing the association "belongs to" the other model.']}),"\n",(0,a.jsxs)(s.p,{children:["In the belongs to, ",(0,a.jsx)(s.code,{children:"class_name"})," is the name of the class that the association points to. ",(0,a.jsx)(s.code,{children:"foreign_key"})," is the name of the field in the current model that references the associated model."]}),"\n",(0,a.jsx)(s.p,{children:"They are optional and will be inferred from the association name if not provided."}),"\n",(0,a.jsx)(s.p,{children:"Class name follows Pascal case and foreign key follows snake case."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Teacher < CouchbaseOrm::Base\n ...\nend\nclass Student < CouchbaseOrm::Base\n  attribute :name, :string\n  attribute :grade, :integer\n  attribute :teacher_id, :string\n\n  belongs_to :teacher, class_name: 'Teacher', foreign_key: :teacher_id\n\n  validates_presence_of :name, :grade, :teacher_id\nend\n\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Student"})," belongs to a ",(0,a.jsx)(s.code,{children:"Teacher"}),". CouchbaseOrm assumes that the ",(0,a.jsx)(s.code,{children:"students"})," documents contain a ",(0,a.jsx)(s.code,{children:"teacher_id"})," field that references the associated teacher document."]}),"\n",(0,a.jsx)(s.h2,{id:"62-has-many",children:"6.2. Has Many"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"has_many"})," association is used to define a one-to-many relationship between two models, where one model can have multiple associated records of another model."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Teacher < CouchbaseOrm::Base\n  attribute :name, :string\n  attribute :subject, :string\n\n  has_many :students, class_name: 'Student', foreign_key: :teacher_id, type: :n1ql, dependent: :destroy\n\n  validates_presence_of :name, :subject\nend\n\nclass Student < CouchbaseOrm::Base\n ...\nend\n\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Teacher"})," has many ",(0,a.jsx)(s.code,{children:"Student"}),"s, and a ",(0,a.jsx)(s.code,{children:"Student"})," belongs to a ",(0,a.jsx)(s.code,{children:"Teacher"}),". CouchbaseOrm assumes that the ",(0,a.jsx)(s.code,{children:"students"})," documents contain a ",(0,a.jsx)(s.code,{children:"teacher_id"})," field that references the associated teacher document."]}),"\n",(0,a.jsx)(s.p,{children:"The class name and foreign key are optional and will be inferred from the association name if not provided."}),"\n",(0,a.jsx)(s.p,{children:"In the following example, we demonstrate how to work with associations in CouchbaseOrm:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"# Creating a new teacher\nteacher1 = Teacher.create(name: 'Mr. Smith', subject: 'Mathematics')\n\n# Creating new students\nstudent1 = Student.create(name: 'John Doe', grade: 9, teacher_id: teacher1.id)\nstudent2 = Student.create(name: 'Jane Roe', grade: 10, teacher_id: teacher1.id)\n\n# Associating students with teacher\nputs \"Teacher's students: #{teacher1.students.inspect}\"\n\n# Find a teacher by a student's teacher_id\nfound_teacher = Teacher.find(student1.teacher_id)\nputs found_teacher.inspect\n\n# List students of a teacher\nteacher1.reload\nteacher_students = teacher1.students\nteacher_students.each { |student| puts student.inspect }\n"})}),"\n",(0,a.jsx)(s.h2,{id:"63-has-and-belongs-to-many",children:"6.3. Has And Belongs To Many"}),"\n",(0,a.jsxs)(s.p,{children:["The ",(0,a.jsx)(s.code,{children:"has_and_belongs_to_many"})," association is used to define a many-to-many relationship between two models, where each model can have multiple associated records of the other model."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Publisher < CouchbaseOrm::Base\n  attribute :name, :string\n  has_and_belongs_to_many :magazines, join_class: 'PublishersMagazines'\n\n  validates :name, presence: true\nend\n\nclass Magazine < CouchbaseOrm::Base\n  attribute :title, :string\n  attribute :genre, :string\n  has_and_belongs_to_many :publishers, join_class: 'PublishersMagazines'\n\n  validates :title, presence: true\n  validates :genre, presence: true\nend\n\nclass PublishersMagazines < CouchbaseOrm::Base\n  attribute :publisher_id, :string\n  attribute :magazine_id, :string\n\n  validates :publisher_id, presence: true\n  validates :magazine_id, presence: true\nend\n\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Publisher"})," has and belongs to many ",(0,a.jsx)(s.code,{children:"Magazine"}),"s, and a ",(0,a.jsx)(s.code,{children:"Magazine"})," has and belongs to many ",(0,a.jsx)(s.code,{children:"Publisher"}),"s. The ",(0,a.jsx)(s.code,{children:"PublishersMagazines"})," class serves as the join class that connects the ",(0,a.jsx)(s.code,{children:"Publisher"})," and ",(0,a.jsx)(s.code,{children:"Magazine"})," models."]}),"\n",(0,a.jsx)(s.p,{children:"You can customize the association name, class name, and foreign key if needed:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Publisher < CouchbaseOrm::Base\n  has_and_belongs_to_many :books, class_name: 'Book', join_table: 'publishers_books', foreign_key: 'publisher_id', association_foreign_key: 'book_id'\nend\n"})}),"\n",(0,a.jsx)(s.p,{children:"In the following example, we demonstrate how to work with many-to-many associations in CouchbaseOrm:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"# Create magazines\nmagazine1 = Magazine.create(title: 'Vogue', genre: 'Fashion')\nmagazine2 = Magazine.create(title: 'National Geographic', genre: 'Science')\n\n# Create publishers\npublisher1 = Publisher.create(name: 'Penguin Random House')\npublisher2 = Publisher.create(name: 'Hearst Communications')\n\n# Associate publishers with magazines\npublisher1.magazines = [magazine1, magazine2]\npublisher2.magazines = [magazine1]\npublisher1.save\npublisher2.save\n\nmagazine1.publishers = [publisher1, publisher2]\nmagazine2.publishers = [publisher1]\nmagazine1.save\nmagazine2.save\n\n# Print publishers and their magazines\nputs Publisher.all.map { |publisher| \"#{publisher.name} (ID: #{publisher.id})\" }\n\n# Print magazines and their publishers \nputs Magazine.all.map { |magazine| \"#{magazine.title} (Genre: #{magazine.genre}) by #{magazine.publishers.map(&:name).join(', ')} (ID: #{magazine.id})\" }\n\n# print magazine and tojson\nputs Magazine.all.map { |magazine| \"#{magazine.to_json}\" }\n"})}),"\n",(0,a.jsx)(s.h2,{id:"64-polymorphic-associations",children:"6.4. Polymorphic Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm supports polymorphic associations, which allow a model to belong to multiple other models through a single association."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class Comment < CouchbaseOrm::Base\n  belongs_to :commentable, polymorphic: true\nend\n\nclass Post < CouchbaseOrm::Base\n  has_many :comments, as: :commentable\nend\n\nclass Photo < CouchbaseOrm::Base\n  has_many :comments, as: :commentable\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, a ",(0,a.jsx)(s.code,{children:"Comment"})," can belong to either a ",(0,a.jsx)(s.code,{children:"Post"})," or a ",(0,a.jsx)(s.code,{children:"Photo"})," through the ",(0,a.jsx)(s.code,{children:"commentable"})," association. The ",(0,a.jsx)(s.code,{children:"commentable_type"})," field in the ",(0,a.jsx)(s.code,{children:"comments"})," document stores the type of the associated record (",(0,a.jsx)(s.code,{children:"Post"})," or ",(0,a.jsx)(s.code,{children:"Photo"}),"), and the ",(0,a.jsx)(s.code,{children:"commentable_id"})," field stores the ID of the associated record."]}),"\n",(0,a.jsx)(s.h2,{id:"65-dependent-associations",children:"6.5. Dependent Associations"}),"\n",(0,a.jsxs)(s.p,{children:["CouchbaseOrm allows you to specify what should happen to associated records when the parent record is destroyed. You can use the ",(0,a.jsx)(s.code,{children:"dependent"})," option to control this behavior."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts, dependent: :destroy\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, when a ",(0,a.jsx)(s.code,{children:"User"})," is destroyed, all associated ",(0,a.jsx)(s.code,{children:"Post"}),"s will also be destroyed. Other options for ",(0,a.jsx)(s.code,{children:"dependent"})," include ",(0,a.jsx)(s.code,{children:":nullify"})," (sets the foreign key to null), ",(0,a.jsx)(s.code,{children:":restrict_with_exception"})," (raises an exception if there are associated records), and ",(0,a.jsx)(s.code,{children:":delete_all"})," (deletes associated records without running callbacks)."]}),"\n",(0,a.jsx)(s.h2,{id:"66-autosave",children:"6.6. Autosave"}),"\n",(0,a.jsxs)(s.p,{children:["CouchbaseOrm provides an ",(0,a.jsx)(s.code,{children:"autosave"})," option that automatically saves associated records when saving the parent record."]}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  has_many :posts, autosave: true\nend\n"})}),"\n",(0,a.jsxs)(s.p,{children:["With ",(0,a.jsx)(s.code,{children:"autosave"})," set to ",(0,a.jsx)(s.code,{children:"true"}),", saving a ",(0,a.jsx)(s.code,{children:"User"})," will also save any new or modified associated ",(0,a.jsx)(s.code,{children:"Post"}),"s."]}),"\n",(0,a.jsx)(s.h2,{id:"67-querying-associations",children:"6.7. Querying Associations"}),"\n",(0,a.jsx)(s.p,{children:"CouchbaseOrm allows you to easily query and retrieve associated records using the defined associations."}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"user = User.find('user_id_123')\nposts = user.posts\n"})}),"\n",(0,a.jsxs)(s.p,{children:["In this example, ",(0,a.jsx)(s.code,{children:"user.posts"})," retrieves all the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s for the given ",(0,a.jsx)(s.code,{children:"User"}),"."]}),"\n",(0,a.jsx)(s.p,{children:"You can also chain query methods on associations:"}),"\n",(0,a.jsx)(s.pre,{children:(0,a.jsx)(s.code,{className:"language-ruby",children:"recent_posts = user.posts.where('created_at >= ?', 1.week.ago).order(created_at: :desc)\n"})}),"\n",(0,a.jsxs)(s.p,{children:["This query retrieves the associated ",(0,a.jsx)(s.code,{children:"Post"}),"s for the user that were created within the last week, ordered by the most recent first."]}),"\n",(0,a.jsx)(s.p,{children:"Now, let's move on to the next section, where we'll explore how to use N1QL queries in CouchbaseOrm for more advanced querying capabilities."})]})}function h(e={}){const{wrapper:s}={...(0,t.R)(),...e.components};return s?(0,a.jsx)(s,{...e,children:(0,a.jsx)(l,{...e})}):l(e)}},8453:(e,s,n)=>{n.d(s,{R:()=>o,x:()=>r});var a=n(6540);const t={},i=a.createContext(t);function o(e){const s=a.useContext(i);return a.useMemo((function(){return"function"==typeof e?e(s):{...s,...e}}),[s,e])}function r(e){let s;return s=e.disableParentContext?"function"==typeof e.components?e.components(t):e.components||t:o(e.components),a.createElement(i.Provider,{value:s},e.children)}}}]);