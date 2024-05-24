"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[702],{1956:(e,i,n)=>{n.r(i),n.d(i,{assets:()=>a,contentTitle:()=>c,default:()=>l,frontMatter:()=>t,metadata:()=>o,toc:()=>d});var s=n(4848),r=n(8453);const t={},c="Views",o={id:"tutorial-ruby-couchbase-orm/views",title:"Views",description:"CouchbaseOrm provides support for using views to query and index your data. Views are a powerful feature of Couchbase Server that allow you to define custom map-reduce functions to extract, filter, and aggregate your data.",source:"@site/docs/tutorial-ruby-couchbase-orm/08-views.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/views",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/views",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/08-views.md",tags:[],version:"current",sidebarPosition:8,frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"SQL++ (formerly N1QL) Queries",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/sqlpp-queries"},next:{title:"Nested Documents",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/nested-documents"}},a={},d=[{value:"8.1. Defining Views",id:"81-defining-views",level:2},{value:"8.2. Querying Views",id:"82-querying-views",level:2},{value:"8.3. View Options",id:"83-view-options",level:2},{value:"8.4. Indexing Views",id:"84-indexing-views",level:2},{value:"8.5. Querying with Keys",id:"85-querying-with-keys",level:2},{value:"8.6. Reducing Results",id:"86-reducing-results",level:2},{value:"8.7. Querying with Pagination",id:"87-querying-with-pagination",level:2}];function u(e){const i={code:"code",h1:"h1",h2:"h2",li:"li",p:"p",pre:"pre",ul:"ul",...(0,r.R)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(i.h1,{id:"views",children:"Views"}),"\n",(0,s.jsx)(i.p,{children:"CouchbaseOrm provides support for using views to query and index your data. Views are a powerful feature of Couchbase Server that allow you to define custom map-reduce functions to extract, filter, and aggregate your data."}),"\n",(0,s.jsx)(i.h2,{id:"81-defining-views",children:"8.1. Defining Views"}),"\n",(0,s.jsxs)(i.p,{children:["To define a view in your model, you can use the ",(0,s.jsx)(i.code,{children:"view"})," class method provided by CouchbaseOrm."]}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"class User < CouchbaseOrm::Base\n  view :by_email, \"function(doc) { if (doc.type === 'user' && doc.email) { emit(doc.email, null); } }\"\nend\n"})}),"\n",(0,s.jsxs)(i.p,{children:["In this example, we define a view named ",(0,s.jsx)(i.code,{children:"by_email"})," that indexes users by their email address. The view function checks if the document is of type ",(0,s.jsx)(i.code,{children:"'user'"})," and has an ",(0,s.jsx)(i.code,{children:"email"})," attribute. If so, it emits the email as the key and ",(0,s.jsx)(i.code,{children:"null"})," as the value."]}),"\n",(0,s.jsx)(i.h2,{id:"82-querying-views",children:"8.2. Querying Views"}),"\n",(0,s.jsx)(i.p,{children:"To query a view, you can use the view name as a method on your model class."}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"users = User.by_email\n"})}),"\n",(0,s.jsxs)(i.p,{children:["This will execute the ",(0,s.jsx)(i.code,{children:"by_email"})," view and return the results as an array of model instances."]}),"\n",(0,s.jsx)(i.p,{children:"You can also pass query options to the view:"}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"users = User.by_email(key: 'john@example.com', include_docs: true)\n"})}),"\n",(0,s.jsx)(i.p,{children:"Some commonly used query options include:"}),"\n",(0,s.jsxs)(i.ul,{children:["\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"key"}),": Specifies a specific key to match."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"startkey"})," and ",(0,s.jsx)(i.code,{children:"endkey"}),": Specifies a range of keys to match."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"limit"}),": Specifies the maximum number of results to return."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"skip"}),": Specifies the number of results to skip before starting to return results."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"include_docs"}),": Specifies whether to include the full document content in the results."]}),"\n"]}),"\n",(0,s.jsx)(i.h2,{id:"83-view-options",children:"8.3. View Options"}),"\n",(0,s.jsx)(i.p,{children:"When defining a view, you can specify additional options to control the behavior of the view."}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:'class User < CouchbaseOrm::Base\n  view :by_created_at, "function(doc) { if (doc.type === \'user\' && doc.created_at) { emit(doc.created_at, null); } }", reduce: "_count"\nend\n'})}),"\n",(0,s.jsxs)(i.p,{children:["In this example, we define a view named ",(0,s.jsx)(i.code,{children:"by_created_at"})," that indexes users by their creation date. We also specify a reduce function ",(0,s.jsx)(i.code,{children:'"_count"'})," to count the number of users for each creation date."]}),"\n",(0,s.jsx)(i.p,{children:"Other commonly used view options include:"}),"\n",(0,s.jsxs)(i.ul,{children:["\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"map"}),": Specifies the map function for the view."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"reduce"}),": Specifies the reduce function for the view."]}),"\n",(0,s.jsxs)(i.li,{children:[(0,s.jsx)(i.code,{children:"include_docs"}),": Specifies whether to include the full document content in the view results."]}),"\n"]}),"\n",(0,s.jsx)(i.h2,{id:"84-indexing-views",children:"8.4. Indexing Views"}),"\n",(0,s.jsxs)(i.p,{children:["CouchbaseOrm automatically indexes your views when the application starts or when the ",(0,s.jsx)(i.code,{children:"Model.ensure_views!"})," method is called."]}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"User.ensure_views!\n"})}),"\n",(0,s.jsx)(i.p,{children:"This ensures that the views defined in your models are created and indexed in Couchbase Server."}),"\n",(0,s.jsx)(i.h2,{id:"85-querying-with-keys",children:"8.5. Querying with Keys"}),"\n",(0,s.jsx)(i.p,{children:"You can query a view by specifying specific keys or a range of keys."}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"users = User.by_email(key: 'john@example.com')\nusers = User.by_created_at(startkey: Time.now - 1.day, endkey: Time.now)\n"})}),"\n",(0,s.jsxs)(i.p,{children:["In the first example, we query the ",(0,s.jsx)(i.code,{children:"by_email"})," view with a specific key to find users with the email ",(0,s.jsx)(i.code,{children:"'john@example.com'"}),"."]}),"\n",(0,s.jsxs)(i.p,{children:["In the second example, we query the ",(0,s.jsx)(i.code,{children:"by_created_at"})," view with a range of keys to find users created within the last day."]}),"\n",(0,s.jsx)(i.h2,{id:"86-reducing-results",children:"8.6. Reducing Results"}),"\n",(0,s.jsx)(i.p,{children:"If your view includes a reduce function, you can retrieve the reduced results instead of the full result set."}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"count = User.by_created_at(reduce: true)\n"})}),"\n",(0,s.jsxs)(i.p,{children:["In this example, we query the ",(0,s.jsx)(i.code,{children:"by_created_at"})," view with the ",(0,s.jsx)(i.code,{children:"reduce"})," option set to ",(0,s.jsx)(i.code,{children:"true"}),". This returns the reduced result, which is the count of users for each creation date."]}),"\n",(0,s.jsx)(i.h2,{id:"87-querying-with-pagination",children:"8.7. Querying with Pagination"}),"\n",(0,s.jsxs)(i.p,{children:["CouchbaseOrm allows you to paginate through view results using the ",(0,s.jsx)(i.code,{children:"limit"})," and ",(0,s.jsx)(i.code,{children:"skip"})," options."]}),"\n",(0,s.jsx)(i.pre,{children:(0,s.jsx)(i.code,{className:"language-ruby",children:"page1 = User.by_created_at(limit: 10)\npage2 = User.by_created_at(limit: 10, skip: 10)\n"})}),"\n",(0,s.jsxs)(i.p,{children:["In this example, we query the ",(0,s.jsx)(i.code,{children:"by_created_at"})," view with a limit of 10 results per page. The first query retrieves the first page of results, and the second query retrieves the second page by skipping the first 10 results."]}),"\n",(0,s.jsx)(i.p,{children:"Views in CouchbaseOrm provide a flexible and efficient way to query and aggregate your data. By defining custom map-reduce functions, you can create indexes tailored to your specific querying needs."}),"\n",(0,s.jsx)(i.p,{children:"It's important to design your views carefully, considering the querying patterns and performance requirements of your application. Proper indexing and querying can significantly improve the performance and scalability of your application."}),"\n",(0,s.jsx)(i.p,{children:"In the next section, we'll explore how to work with nested documents in CouchbaseOrm, allowing you to model complex data structures within a single document."})]})}function l(e={}){const{wrapper:i}={...(0,r.R)(),...e.components};return i?(0,s.jsx)(i,{...e,children:(0,s.jsx)(u,{...e})}):u(e)}},8453:(e,i,n)=>{n.d(i,{R:()=>c,x:()=>o});var s=n(6540);const r={},t=s.createContext(r);function c(e){const i=s.useContext(t);return s.useMemo((function(){return"function"==typeof e?e(i):{...i,...e}}),[i,e])}function o(e){let i;return i=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:c(e.components),s.createElement(t.Provider,{value:i},e.children)}}}]);