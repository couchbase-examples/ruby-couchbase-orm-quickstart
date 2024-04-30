# Quickstart in Couchbase with Ruby Couchbase ORM

## Build a REST API with Ruby Couchbase ORM

Often, the first step developers take after creating their database is to create a REST API capable of performing Create, Read, Update, and Delete (CRUD) operations for that database. This repository is designed to teach you and provide you with a starter project (in Ruby on Rails) to generate such a REST API. Once you have installed the travel-sample bucket in your database, you can run this application, which is a REST API with Swagger documentation, to learn:

- How to create, read, update, and delete documents using Key-value operations (KV operations). Key-value operations are unique to Couchbase and provide super-fast (think microseconds) queries.
- How to write simple parameterized SQL++ queries using the built-in travel-sample bucket.

You can find the full documentation for the tutorial on the [Couchbase Developer Portal](https://www.couchbase.com/developers)

## Prerequisites

To run this prebuilt project, you will need:

- [Couchbase Capella cluster](https://www.couchbase.com/products/capella/) with [travel-sample bucket](https://docs.couchbase.com/ruby-sdk/current/ref/travel-app-data-model.html) loaded.
- To run this tutorial using a [self-managed Couchbase cluster](https://docs.couchbase.com/capella/current/getting-started/self-managed-cluster.html), please refer to the appendix.
- [Ruby 3.3.0](https://www.ruby-lang.org/en/documentation/installation/) is installed on the local machine.
- Basic knowledge of [Ruby](https://www.ruby-lang.org/en/documentation/), [Ruby on Rails](https://rubyonrails.org/), and [RSpec](https://rspec.info/).

## Loading Travel Sample Bucket

If travel-sample is not loaded in your Capella cluster, you can load it by following the instructions for your Capella Cluster:

- Load travel-sample bucket in Couchbase Capella

## App Setup

We will walk through the different steps required to get the application running.

### Cloning Repo

```sh
git clone https://github.com/couchbase-examples/ruby-couchbase-orm-quickstart.git
```

### Install Dependencies

Any dependencies will be installed by running the bundle install command, which installs any dependencies required for the project.

```sh
bundle install
```

### Setup Database Configuration

To learn more about connecting to your Capella cluster, please follow the instructions.

Specifically, you need to do the following:

Open the `config/couchbase.yml` file and update the connection string, username, password, and bucket name for the development and test environments.

```yml
common: &common
  connection_string: couchbase://localhost
  username: Administrator
  password: password

development:
  <<: *common
  bucket: travel-sample

test:
  <<: *common
  bucket: travel-sample
```

> Note: The connection string expects the `couchbases://` or `couchbase://` part.

## Running The Application

### Directly on machine

At this point, we have installed the dependencies, loaded the travel-sample data and configured the application with the credentials. The application is now ready and you can run it.

The application will run on a port specified by Rails. You can find the port in the terminal after running the application. You will find the Swagger documentation at [http://localhost:3000/api-docs](http://localhost:3000/api-docs) of the API if you go to the URL in your browser.

```sh
rails server
```

### Using Docker

- Build the Docker image

```sh
docker build -t ruby-couchbase-orm-quickstart .
```

- Run the Docker image

```sh
docker run -p 3000:3000 ruby-couchbase-orm-quickstart -e DB_CONN_STR=<connection_string> -e DB_USERNAME=<user_with_read_write_permission_to_travel-sample_bucket> -e DB_PASSWORD=<password_for_user>
```

## Verifying the Application

Once the application starts, you can see the details of the application on the terminal.

Show Image

The application will run on the port specified by Rails on your local machine (eg: http://localhost:3000). You will find the interactive Swagger documentation of the API if you go to the URL in your browser. Swagger documentation is used in this demo to showcase the different API endpoints and how they can be invoked. More details on the Swagger documentation can be found in the appendix.

Show Image

## Running The Tests

The application comes with a set of integration tests that can be run to verify the functionality of the application. The tests are written using RSpec, a popular testing framework for Ruby.

To run the tests, you can use the following command:

```sh
bundle exec rspec test/integration
```

# Appendix

## Data Model

For this quickstart, we use three collections, airport, airline and routes that contain sample airports, airlines and airline routes respectively. The route collection connects the airports and airlines as seen in the figure below. We use these connections in the quickstart to generate airports that are directly connected and airlines connecting to a destination airport. Note that these are just examples to highlight how you can use SQL++ queries to join the collections.

![Data Model](image_link)

## Extending API by Adding New Entity

If you would like to add another entity to the APIs, these are the steps to follow:

1. Create a new model: Create a new model for the entity in the `app/models` folder. This model should contain the schema for the entity.
2. Create the new route: In Rails, you can create a new route by adding a new resource in the `config/routes.rb` file. This file should contain the logic for the new entity's CRUD operations.
3. Create the new controller: Create a new controller for the entity in the `app/controllers` folder. This controller should contain the logic for the new entity's CRUD operations.
4. Add the integration tests: Add integration tests for the new entity in the `test/integration` folder. This ensures that the new entity's CRUD operations are tested. The test file should be named `<entity>_spec.rb`.

Following these steps ensures a systematic and organized approach to expanding the API functionality with a new entity.

## Running Self-Managed Couchbase Cluster

If you are running this quickstart with a self-managed Couchbase cluster, you need to load the travel-sample data bucket in your cluster and generate the credentials for the bucket by creating a user.

You need to update the connection string and the credentials in the `dev.env` file in the root folder.

Note: Couchbase Server must be installed and running prior to running this app.

## Swagger Documentation

Swagger documentation provides a clear view of the API including endpoints, HTTP methods, request parameters, and response objects.

Click on an individual endpoint to expand it and see detailed information. This includes the endpoint's description, possible response status codes, and the request parameters it accepts.

### Trying Out the API

You can try out an API by clicking on the "Try it out" button next to the endpoints.

Parameters: If an endpoint requires parameters, Swagger UI provides input boxes for you to fill in. This could include path parameters, query strings, headers, or the body of a POST/PUT request.

Execution: Once you've inputted all the necessary parameters, you can click the "Execute" button to make a live API call. Swagger UI will send the request to the API and display the response directly in the documentation. This includes the response code, response headers, and response body.

### Models

Swagger documents the structure of request and response bodies using models. These models define the expected data structure using JSON schema and are extremely helpful in understanding what data to send and expect.
