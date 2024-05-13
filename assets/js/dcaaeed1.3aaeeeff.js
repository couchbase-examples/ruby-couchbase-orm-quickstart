"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[8841],{6453:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>a,default:()=>l,frontMatter:()=>r,metadata:()=>o,toc:()=>i});var s=n(4848),d=n(8453);const r={sidebar_position:"09"},a="Nested Documents",o={id:"tutorial-ruby-couchbase-orm/nested-documents",title:"Nested Documents",description:"CouchbaseOrm supports nested documents, which allow you to store complex, hierarchical data structures within a single Couchbase document. Nested documents are useful when you have related data that you want to store together with the parent document for performance or consistency reasons.",source:"@site/docs/tutorial-ruby-couchbase-orm/09-nested-documents.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/nested-documents",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/nested-documents",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/09-nested-documents.md",tags:[],version:"current",sidebarPosition:9,frontMatter:{sidebar_position:9},sidebar:"tutorialSidebar",previous:{title:"Views",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/views"},next:{title:"Enums",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/enums"}},c={},i=[{value:"9.1. Defining Nested Documents",id:"91-defining-nested-documents",level:2},{value:"9.2. Embedding Documents",id:"92-embedding-documents",level:2},{value:"9.3. Accessing Nested Documents",id:"93-accessing-nested-documents",level:2},{value:"9.4. Updating Nested Documents",id:"94-updating-nested-documents",level:2},{value:"9.5. Embedding Multiple Documents",id:"95-embedding-multiple-documents",level:2},{value:"9.6. Querying Nested Documents",id:"96-querying-nested-documents",level:2},{value:"9.7. Validating Nested Documents",id:"97-validating-nested-documents",level:2}];function u(e){const t={code:"code",h1:"h1",h2:"h2",p:"p",pre:"pre",...(0,d.R)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(t.h1,{id:"nested-documents",children:"Nested Documents"}),"\n",(0,s.jsx)(t.p,{children:"CouchbaseOrm supports nested documents, which allow you to store complex, hierarchical data structures within a single Couchbase document. Nested documents are useful when you have related data that you want to store together with the parent document for performance or consistency reasons."}),"\n",(0,s.jsx)(t.h2,{id:"91-defining-nested-documents",children:"9.1. Defining Nested Documents"}),"\n",(0,s.jsxs)(t.p,{children:["To define an nested document, you create a new class that inherits from ",(0,s.jsx)(t.code,{children:"CouchbaseOrm::NestedDocument"}),"."]}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"class Address < CouchbaseOrm::NestedDocument\n  attribute :street, :string\n  attribute :city, :string\n  attribute :country, :string\nend\n\nclass User < CouchbaseOrm::Base\n  attribute :name, :string\n  attribute :email, :string\n  attribute :address, Address\nend\n"})}),"\n",(0,s.jsxs)(t.p,{children:["In this example, we define an ",(0,s.jsx)(t.code,{children:"Address"})," class as an nested document and include it as an attribute in the ",(0,s.jsx)(t.code,{children:"User"})," model using the ",(0,s.jsx)(t.code,{children:"attribute"})," method."]}),"\n",(0,s.jsx)(t.h2,{id:"92-embedding-documents",children:"9.2. Embedding Documents"}),"\n",(0,s.jsx)(t.p,{children:"To embed a document within a parent document, you can assign an instance of the nested document class to the corresponding attribute."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"user = User.new(name: 'John Doe', email: 'john@example.com')\nuser.address = Address.new(street: '123 Main St', city: 'New York', country: 'USA')\nuser.save\n"})}),"\n",(0,s.jsxs)(t.p,{children:["When saving the parent document (",(0,s.jsx)(t.code,{children:"User"})," in this case), CouchbaseOrm automatically serializes the nested document (",(0,s.jsx)(t.code,{children:"Address"}),") and stores it as a nested object within the parent document."]}),"\n",(0,s.jsx)(t.h2,{id:"93-accessing-nested-documents",children:"9.3. Accessing Nested Documents"}),"\n",(0,s.jsx)(t.p,{children:"To access an nested document, you can simply call the corresponding attribute on the parent document."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"user = User.find('user_id')\naddress = user.address\nputs address.street\n"})}),"\n",(0,s.jsx)(t.p,{children:"CouchbaseOrm automatically deserializes the nested document and returns an instance of the nested document class."}),"\n",(0,s.jsx)(t.h2,{id:"94-updating-nested-documents",children:"9.4. Updating Nested Documents"}),"\n",(0,s.jsx)(t.p,{children:"To update an nested document, you can modify the attributes of the nested document instance and save the parent document."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"user = User.find('user_id')\nuser.address.city = 'Los Angeles'\nuser.save\n"})}),"\n",(0,s.jsx)(t.p,{children:"CouchbaseOrm will serialize the updated nested document and save it along with the parent document."}),"\n",(0,s.jsx)(t.h2,{id:"95-embedding-multiple-documents",children:"9.5. Embedding Multiple Documents"}),"\n",(0,s.jsx)(t.p,{children:"You can also embed multiple documents within a parent document using an array attribute."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  attribute :name, :string\n  attribute :email, :string\n  attribute :addresses, :array, type: Address\nend\n\nuser = User.new(name: 'John Doe', email: 'john@example.com')\nuser.addresses = [\n  Address.new(street: '123 Main St', city: 'New York', country: 'USA'),\n  Address.new(street: '456 Oak St', city: 'San Francisco', country: 'USA')\n]\nuser.save\n"})}),"\n",(0,s.jsxs)(t.p,{children:["In this example, the ",(0,s.jsx)(t.code,{children:"User"})," model has an ",(0,s.jsx)(t.code,{children:"addresses"})," attribute that is an array of ",(0,s.jsx)(t.code,{children:"Address"})," nested documents. You can assign an array of ",(0,s.jsx)(t.code,{children:"Address"})," instances to the ",(0,s.jsx)(t.code,{children:"addresses"})," attribute and save the parent document."]}),"\n",(0,s.jsx)(t.h2,{id:"96-querying-nested-documents",children:"9.6. Querying Nested Documents"}),"\n",(0,s.jsx)(t.p,{children:"CouchbaseOrm allows you to query nested documents using dot notation and attribute conditions."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"users = User.where('address.city': 'New York')\n"})}),"\n",(0,s.jsxs)(t.p,{children:["This query retrieves all users who have an nested ",(0,s.jsx)(t.code,{children:"Address"})," document with the ",(0,s.jsx)(t.code,{children:"city"})," attribute set to ",(0,s.jsx)(t.code,{children:"'New York'"}),"."]}),"\n",(0,s.jsx)(t.p,{children:"You can also query nested documents within an array attribute."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"users = User.where('addresses.country': 'USA')\n"})}),"\n",(0,s.jsxs)(t.p,{children:["This query retrieves all users who have at least one nested ",(0,s.jsx)(t.code,{children:"Address"})," document with the ",(0,s.jsx)(t.code,{children:"country"})," attribute set to ",(0,s.jsx)(t.code,{children:"'USA'"}),"."]}),"\n",(0,s.jsx)(t.h2,{id:"97-validating-nested-documents",children:"9.7. Validating Nested Documents"}),"\n",(0,s.jsx)(t.p,{children:"CouchbaseOrm allows you to validate nested documents along with the parent document."}),"\n",(0,s.jsx)(t.pre,{children:(0,s.jsx)(t.code,{className:"language-ruby",children:"class Address < CouchbaseOrm::NestedDocument\n  attribute :street, :string\n  attribute :city, :string\n  attribute :country, :string\n\n  validates :street, :city, :country, presence: true\nend\n\nclass User < CouchbaseOrm::Base\n  attribute :name, :string\n  attribute :email, :string\n  attribute :address, Address\n\n  validates :address, presence: true\nend\n"})}),"\n",(0,s.jsxs)(t.p,{children:["In this example, we define validations for the ",(0,s.jsx)(t.code,{children:"Address"})," nested document, ensuring that the ",(0,s.jsx)(t.code,{children:"street"}),", ",(0,s.jsx)(t.code,{children:"city"}),", and ",(0,s.jsx)(t.code,{children:"country"})," attributes are present. We also add a validation to the ",(0,s.jsx)(t.code,{children:"User"})," model to ensure that the ",(0,s.jsx)(t.code,{children:"address"})," attribute is present."]}),"\n",(0,s.jsxs)(t.p,{children:["When saving a ",(0,s.jsx)(t.code,{children:"User"})," document, CouchbaseOrm will validate both the parent document and the nested ",(0,s.jsx)(t.code,{children:"Address"})," document. If any validation fails, the parent document will not be saved, and validation errors will be added to the parent document."]}),"\n",(0,s.jsx)(t.p,{children:"Nested documents provide a powerful way to model complex data structures and relationships within a single Couchbase document. They allow you to store related data together, improving performance and reducing the need for separate queries to retrieve associated data."}),"\n",(0,s.jsx)(t.p,{children:"However, it's important to consider the trade-offs when using nested documents. Embedding too much data within a single document can lead to large document sizes and potential performance issues. It's recommended to use nested documents judiciously and to consider the access patterns and data relationships of your application."}),"\n",(0,s.jsx)(t.p,{children:"In the next section, we'll explore enums in CouchbaseOrm and how they can be used to define a fixed set of values for an attribute."})]})}function l(e={}){const{wrapper:t}={...(0,d.R)(),...e.components};return t?(0,s.jsx)(t,{...e,children:(0,s.jsx)(u,{...e})}):u(e)}},8453:(e,t,n)=>{n.d(t,{R:()=>a,x:()=>o});var s=n(6540);const d={},r=s.createContext(d);function a(e){const t=s.useContext(r);return s.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function o(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(d):e.components||d:a(e.components),s.createElement(r.Provider,{value:t},e.children)}}}]);