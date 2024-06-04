"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[531],{6246:(e,t,i)=>{i.r(t),i.d(t,{assets:()=>c,contentTitle:()=>r,default:()=>d,frontMatter:()=>o,metadata:()=>a,toc:()=>l});var n=i(4848),s=i(8453);const o={},r="Introduction",a={id:"tutorial-ruby-couchbase-orm/introduction",title:"Introduction",description:"Welcome to the documentation for Couchbase ORM, an Object-Relational Mapping (ORM) library for Ruby that simplifies interactions with Couchbase Server. This guide will walk you through the features and usage of Couchbase ORM, helping you build efficient and scalable Ruby applications with Couchbase.",source:"@site/docs/tutorial-ruby-couchbase-orm/01-introduction.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/introduction",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/introduction",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/01-introduction.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Tutorial - Ruby Couchbase ORM",permalink:"/ruby-couchbase-orm-quickstart/docs/category/tutorial---ruby-couchbase-orm"},next:{title:"Installation",permalink:"/ruby-couchbase-orm-quickstart/docs/tutorial-ruby-couchbase-orm/installation"}},c={},l=[{value:"1.1. What is Couchbase ORM?",id:"11-what-is-couchbase-orm",level:2},{value:"1.2. Key Features",id:"12-key-features",level:2},{value:"1.3. Getting Started",id:"13-getting-started",level:2}];function u(e){const t={code:"code",h1:"h1",h2:"h2",li:"li",ol:"ol",p:"p",strong:"strong",ul:"ul",...(0,s.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(t.h1,{id:"introduction",children:"Introduction"}),"\n",(0,n.jsx)(t.p,{children:"Welcome to the documentation for Couchbase ORM, an Object-Relational Mapping (ORM) library for Ruby that simplifies interactions with Couchbase Server. This guide will walk you through the features and usage of Couchbase ORM, helping you build efficient and scalable Ruby applications with Couchbase."}),"\n",(0,n.jsx)(t.h2,{id:"11-what-is-couchbase-orm",children:"1.1. What is Couchbase ORM?"}),"\n",(0,n.jsx)(t.p,{children:"Couchbase ORM is a Ruby library that provides an ActiveRecord-like interface for working with Couchbase Server, a highly scalable and performant NoSQL database. It allows you to define your application's data models as Ruby classes and interact with the database using a familiar and intuitive API."}),"\n",(0,n.jsx)(t.p,{children:"With Couchbase ORM, you can:"}),"\n",(0,n.jsxs)(t.ul,{children:["\n",(0,n.jsx)(t.li,{children:"Define your data models and their relationships"}),"\n",(0,n.jsx)(t.li,{children:"Perform CRUD (Create, Read, Update, Delete) operations on your models"}),"\n",(0,n.jsx)(t.li,{children:"Query your data using a flexible and expressive query language"}),"\n",(0,n.jsx)(t.li,{children:"Use Couchbase-specific features like N1QL queries and views"}),"\n",(0,n.jsx)(t.li,{children:"Implement advanced features such as data validation, callbacks, and associations"}),"\n"]}),"\n",(0,n.jsx)(t.p,{children:"Couchbase ORM abstracts away the low-level details of interacting with Couchbase Server, enabling you to focus on writing business logic and building great applications."}),"\n",(0,n.jsx)(t.h2,{id:"12-key-features",children:"1.2. Key Features"}),"\n",(0,n.jsx)(t.p,{children:"Couchbase ORM offers a wide range of features to make working with Couchbase Server a breeze. Some of the key features include:"}),"\n",(0,n.jsxs)(t.ol,{children:["\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"ActiveModel Compliance"}),": Couchbase ORM follows the ActiveModel API, providing a familiar interface for developers who have worked with ActiveRecord or other ActiveModel-compliant libraries."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Attribute Definition"}),": Easily define your model's attributes and their types using a simple and intuitive DSL."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Querying"}),": Use a powerful and expressive query language to retrieve data from Couchbase Server. Couchbase ORM supports a wide range of query options, including filtering, ordering, limiting, and more."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Persistence"}),": Perform CRUD operations on your models with simple and intuitive methods like ",(0,n.jsx)(t.code,{children:"save"}),", ",(0,n.jsx)(t.code,{children:"create"}),", ",(0,n.jsx)(t.code,{children:"update"}),", and ",(0,n.jsx)(t.code,{children:"destroy"}),"."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Associations"}),": Define relationships between your models, such as one-to-many and many-to-many, using simple declarations."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Validations"}),": Validate your model's data before persisting it to the database using a variety of built-in validators or custom validation methods."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Callbacks"}),": Define callbacks to execute code before or after certain events, such as saving or updating a model."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"N1QL Queries"}),": Execute N1QL queries directly from your Ruby code and map the results to your models."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Views"}),": Create and query Couchbase views to efficiently retrieve data based on specific criteria."]}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsxs)(t.p,{children:[(0,n.jsx)(t.strong,{children:"Nested Documents"}),": Embed related documents within a parent document for denormalized data modeling."]}),"\n"]}),"\n"]}),"\n",(0,n.jsx)(t.p,{children:"These are just a few of the many features offered by Couchbase ORM. Throughout this documentation, we'll explore these features in-depth and provide examples of how to use them in your Ruby applications."}),"\n",(0,n.jsx)(t.h2,{id:"13-getting-started",children:"1.3. Getting Started"}),"\n",(0,n.jsx)(t.p,{children:"To get started with Couchbase ORM, you'll need to have Ruby and Couchbase Server installed on your system. Once you have the prerequisites in place, you can install the Couchbase ORM gem and start building your application."}),"\n",(0,n.jsx)(t.p,{children:"In the next section, we'll walk through the installation process and show you how to configure Couchbase ORM to connect to your Couchbase Server instance."})]})}function d(e={}){const{wrapper:t}={...(0,s.R)(),...e.components};return t?(0,n.jsx)(t,{...e,children:(0,n.jsx)(u,{...e})}):u(e)}},8453:(e,t,i)=>{i.d(t,{R:()=>r,x:()=>a});var n=i(6540);const s={},o=n.createContext(s);function r(e){const t=n.useContext(o);return n.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function a(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:r(e.components),n.createElement(o.Provider,{value:t},e.children)}}}]);