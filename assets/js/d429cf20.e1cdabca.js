"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[633],{9801:(e,o,n)=>{n.r(o),n.d(o,{assets:()=>l,contentTitle:()=>s,default:()=>d,frontMatter:()=>i,metadata:()=>a,toc:()=>c});var r=n(4848),t=n(8453);const i={},s="Logging",a={id:"tutorial-ruby-couchbase-orm/logging",title:"Logging",description:"CouchbaseOrm provides a logging mechanism to help you monitor and debug your application. Logging allows you to capture important events, errors, and information during the execution of your application. CouchbaseOrm integrates with the logging framework used in your Ruby application, such as the built-in Logger class or third-party logging libraries.",source:"@site/docs/tutorial-ruby-couchbase-orm/12-logging.md",sourceDirName:"tutorial-ruby-couchbase-orm",slug:"/tutorial-ruby-couchbase-orm/logging",permalink:"/docs/tutorial-ruby-couchbase-orm/logging",draft:!1,unlisted:!1,editUrl:"https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart/tree/docs/docusaurus/docusaurus/docs/docs/tutorial-ruby-couchbase-orm/12-logging.md",tags:[],version:"current",sidebarPosition:12,frontMatter:{},sidebar:"tutorialSidebar",previous:{title:"Encryption",permalink:"/docs/tutorial-ruby-couchbase-orm/encryption"},next:{title:"Troubleshooting",permalink:"/docs/tutorial-ruby-couchbase-orm/troubleshooting"}},l={},c=[{value:"12.1. Log Levels",id:"121-log-levels",level:2}];function u(e){const o={code:"code",h1:"h1",h2:"h2",li:"li",p:"p",pre:"pre",ul:"ul",...(0,t.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(o.h1,{id:"logging",children:"Logging"}),"\n",(0,r.jsxs)(o.p,{children:["CouchbaseOrm provides a logging mechanism to help you monitor and debug your application. Logging allows you to capture important events, errors, and information during the execution of your application. CouchbaseOrm integrates with the logging framework used in your Ruby application, such as the built-in ",(0,r.jsx)(o.code,{children:"Logger"})," class or third-party logging libraries."]}),"\n",(0,r.jsx)(o.h2,{id:"121-log-levels",children:"12.1. Log Levels"}),"\n",(0,r.jsx)(o.p,{children:"CouchbaseOrm supports different log levels to control the verbosity of the logged messages. The available log levels, in increasing order of severity, are:"}),"\n",(0,r.jsxs)(o.ul,{children:["\n",(0,r.jsxs)(o.li,{children:[(0,r.jsx)(o.code,{children:"DEBUG"}),": Detailed information, typically of interest only when diagnosing problems."]}),"\n",(0,r.jsxs)(o.li,{children:[(0,r.jsx)(o.code,{children:"INFO"}),": Confirmation that things are working as expected."]}),"\n",(0,r.jsxs)(o.li,{children:[(0,r.jsx)(o.code,{children:"WARN"}),": An indication that something unexpected happened or indicative of some problem in the near future."]}),"\n",(0,r.jsxs)(o.li,{children:[(0,r.jsx)(o.code,{children:"ERROR"}),": Due to a more serious problem, the software has not been able to perform some function."]}),"\n",(0,r.jsxs)(o.li,{children:[(0,r.jsx)(o.code,{children:"FATAL"}),": A serious error, indicating that the program itself may be unable to continue running."]}),"\n"]}),"\n",(0,r.jsxs)(o.p,{children:["By default, CouchbaseOrm logs messages at the ",(0,r.jsx)(o.code,{children:"INFO"})," level and above. You can change the log level by exporting the ",(0,r.jsx)(o.code,{children:"COUCHBASE_ORM_DEBUG"})," environment variable with the desired log level. For example, to set the log level to ",(0,r.jsx)(o.code,{children:"DEBUG"}),", you can run:"]}),"\n",(0,r.jsx)(o.pre,{children:(0,r.jsx)(o.code,{className:"language-bash",children:"export COUCHBASE_ORM_DEBUG=Logger::DEBUG\n"})}),"\n",(0,r.jsxs)(o.p,{children:["This command sets the log level to ",(0,r.jsx)(o.code,{children:"DEBUG"}),", which will log detailed information for debugging purposes."]}),"\n",(0,r.jsx)(o.pre,{children:(0,r.jsx)(o.code,{className:"language-ruby",children:"require_relative \"app\"\n\n# Create a new user\nuser = User.new(name: 'John Doe', email: 'john@example.com')\nuser.save\n\n# Update the user's email\nuser.email = 'john.doe@example.com'\nuser.save\n\n# Log a custom message\nCouchbaseOrm.logger.info \"User #{user.id} updated email to #{user.email}\"\n"})}),"\n",(0,r.jsxs)(o.p,{children:["In this example, we create a new ",(0,r.jsx)(o.code,{children:"User"})," instance, save it to the database, update the user's email, and log a custom message using the ",(0,r.jsx)(o.code,{children:"CouchbaseOrm.logger"})," object. The log message includes the user's ID and the updated email address."]}),"\n",(0,r.jsx)(o.p,{children:"Output:"}),"\n",(0,r.jsx)(o.pre,{children:(0,r.jsx)(o.code,{children:'D, [2024-05-24T11:48:00.071104 #234447] DEBUG -- : Initialize model  with {:name=>"John Doe", :email=>"john@example.com"}\nD, [2024-05-24T11:48:00.086972 #234447] DEBUG -- : _create_record - Upsert user-1-vncZNSYZj {"id"=>"user-1-vncZNSYZj", "email"=>"john@example.com", "name"=>"John Doe", "age"=>nil, "height"=>nil, "is_active"=>nil, "birth_date"=>nil, "created_at"=>"2024-05-24T06:18:00Z", "updated_at"=>"2024...\nD, [2024-05-24T11:48:00.113166 #234447] DEBUG -- : _update_record - replace user-1-vncZNSYZj {"id"=>"user-1-vncZNSYZj", "email"=>"john.doe@example.com", "name"=>"John Doe", "age"=>nil, "height"=>nil, "is_active"=>nil, "birth_date"=>nil, "created_at"=>"2024-05-24T06:18:00Z", "updated_at"=>"...\nI, [2024-05-24T11:48:00.115239 #234447]  INFO -- : User user-1-vncZNSYZj updated email to john.doe@example.com\n'})})]})}function d(e={}){const{wrapper:o}={...(0,t.R)(),...e.components};return o?(0,r.jsx)(o,{...e,children:(0,r.jsx)(u,{...e})}):u(e)}},8453:(e,o,n)=>{n.d(o,{R:()=>s,x:()=>a});var r=n(6540);const t={},i=r.createContext(t);function s(e){const o=r.useContext(i);return r.useMemo((function(){return"function"==typeof e?e(o):{...o,...e}}),[o,e])}function a(e){let o;return o=e.disableParentContext?"function"==typeof e.components?e.components(t):e.components||t:s(e.components),r.createElement(i.Provider,{value:o},e.children)}}}]);