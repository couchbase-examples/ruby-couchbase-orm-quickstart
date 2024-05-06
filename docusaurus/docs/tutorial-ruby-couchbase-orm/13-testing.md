# Testing

Testing is an essential part of developing robust and maintainable applications. CouchbaseOrm provides support for testing your models and queries to ensure they behave as expected. In this section, we'll explore how to set up and write tests for your CouchbaseOrm-based application.

## 13.1. Setup

To start testing your CouchbaseOrm models, you'll need to set up your test environment. Here are the steps to get started:

1. **Install testing dependencies**: Make sure you have the necessary testing dependencies installed. If you're using RSpec, you'll need to add the `rspec` gem to your Gemfile:

   ```ruby
   group :test do
     gem 'rspec'
   end
   ```

   Run `bundle install` to install the gem.

2. **Configure test environment**: Create a configuration file for your test environment, specifying the Couchbase connection details and any other relevant settings:

   ```yaml
   # config/couchbase.yml
   test:
     host: localhost
     bucket: my_app_test
     username: my_username
     password: my_password
   ```

   Make sure to use a separate bucket for testing to avoid modifying your development or production data.

3. **Initialize CouchbaseOrm**: In your test setup, initialize CouchbaseOrm with the test configuration:

   ```ruby
   # spec/spec_helper.rb
   require 'couchbase-orm'

   CouchbaseOrm.configure do |config|
     config.load_config(File.join(File.dirname(__FILE__), '..', 'config', 'couchbase.yml'), :test)
   end
   ```

   This code loads the Couchbase configuration from the `config/couchbase.yml` file for the test environment.

## 13.2. Model Tests

Testing your CouchbaseOrm models involves verifying the behavior of your model classes, including attribute definitions, validations, callbacks, and associations. Here's an example of testing a simple model:

```ruby
# spec/models/user_spec.rb
require 'spec_helper'

RSpec.describe User do
  describe 'validations' do
    it 'requires a name' do
      user = User.new(email: 'john@example.com')
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires a valid email' do
      user = User.new(name: 'John Doe', email: 'invalid_email')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('is invalid')
    end
  end

  describe 'callbacks' do
    it 'sets the status to active before saving' do
      user = User.new(name: 'John Doe', email: 'john@example.com')
      expect(user.status).to be_nil
      user.save
      expect(user.status).to eq('active')
    end
  end
end
```

In this example, we test the validations and callbacks of the `User` model. We create instances of the model with different attributes and assert the expected behavior, such as validation errors and callback side effects.

## 13.3. Query Tests

Testing queries involves verifying that your CouchbaseOrm queries return the expected results. Here's an example of testing a query:

```ruby
# spec/queries/active_users_spec.rb
require 'spec_helper'

RSpec.describe 'Active Users Query' do
  let!(:active_user) { User.create(name: 'John', status: 'active') }
  let!(:inactive_user) { User.create(name: 'Jane', status: 'inactive') }

  it 'returns only active users' do
    active_users = User.where(status: 'active')
    expect(active_users).to include(active_user)
    expect(active_users).to_not include(inactive_user)
  end
end
```

In this example, we create test data by creating instances of the `User` model with different statuses. We then execute the query to retrieve active users and assert that the query returns the expected results.

## 13.4. Mocking Couchbase Responses

In some cases, you may want to mock the responses from Couchbase to isolate your tests from the actual database. CouchbaseOrm integrates with popular mocking libraries like RSpec Mocks, allowing you to stub Couchbase responses.

Here's an example of mocking a Couchbase response:

```ruby
# spec/models/user_spec.rb
require 'spec_helper'

RSpec.describe User do
  describe '#find' do
    it 'returns the user when found' do
      user_data = { 'name' => 'John Doe', 'email' => 'john@example.com' }
      allow(CouchbaseOrm::Connection.bucket).to receive(:get).with('user_1').and_return(user_data)

      user = User.find('user_1')
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john@example.com')
    end
  end
end
```

In this example, we use RSpec Mocks to stub the `CouchbaseOrm::Connection.bucket.get` method and return a predefined user data hash. This allows us to test the `find` method without actually querying the Couchbase database.

## 13.5. Test Helpers

To make your tests more readable and maintainable, you can create test helpers that encapsulate common setup or assertions. Here's an example of a test helper:

```ruby
# spec/support/model_helpers.rb
module ModelHelpers
  def create_user(attributes = {})
    User.create({
      name: 'John Doe',
      email: 'john@example.com',
      status: 'active'
    }.merge(attributes))
  end
end

RSpec.configure do |config|
  config.include ModelHelpers
end
```

In this example, we define a `create_user` helper method that creates a `User` instance with default attributes and merges any provided attributes. We then include this helper module in our RSpec configuration, making it available in all our tests.

With test helpers, you can DRY up your test code and make it more expressive:

```ruby
# spec/models/user_spec.rb
require 'spec_helper'

RSpec.describe User do
  describe '#name' do
    it 'returns the user name' do
      user = create_user(name: 'Jane Doe')
      expect(user.name).to eq('Jane Doe')
    end
  end
end
```

## 13.6. Continuous Integration

To ensure the reliability and maintainability of your CouchbaseOrm-based application, it's recommended to set up continuous integration (CI) for running your tests automatically on each code change.

Popular CI services like Travis CI, CircleCI, or GitHub Actions can be easily integrated with your project. They can automatically run your test suite, report test results, and notify you of any failures.

### GitHub Actions

GitHub Actions is a popular CI/CD platform that integrates seamlessly with GitHub repositories. It allows you to define workflows that automatically run your tests, perform code analysis, and deploy your application.

Here's an example configuration for GitHub Actions:

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 2.7

      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y libcouchbase-dev
          gem install bundler
          bundle install --jobs 4 --retry 3

      - name: Set up Couchbase
        run: |
          curl -O http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb
          sudo dpkg -i couchbase-release-1.0-amd64.deb
          sudo apt-get update
          sudo apt-get install -y couchbase-server

      - name: Start Couchbase
        run: sudo systemctl start couchbase-server

      - name: Run tests
        run: bundle exec rspec
```

This GitHub Actions workflow defines a job named `test` that runs on Ubuntu. It performs the following steps:

1. Checks out the code from the repository.
2. Sets up the specified Ruby version using the `ruby/setup-ruby` action.
3. Installs the required dependencies, including `libcouchbase-dev` and the project's gems using Bundler.
4. Sets up Couchbase Server by downloading and installing the necessary packages.
5. Starts the Couchbase Server service.
6. Runs the RSpec tests using the `bundle exec rspec` command.

This workflow will be triggered on every push to the `main` branch and every pull request targeting the `main` branch.

To use this workflow, create a new file named `ci.yml` in the `.github/workflows` directory of your project and copy the above configuration.

GitHub Actions provides a wide range of options and integrations, allowing you to customize your CI/CD pipeline according to your project's needs. You can add additional steps for code coverage reporting, linting, or deploying your application to various environments.

By setting up continuous integration with GitHub Actions, you can automatically run your tests on each code change, ensuring that your CouchbaseOrm-based application remains stable and reliable.

Remember to configure your Couchbase connection details and any other necessary environment variables in the GitHub Actions secrets to keep sensitive information secure.

With continuous integration in place, you can catch issues early, maintain code quality, and deploy your application with confidence.

### Travis CI

Here's an example configuration for Travis CI:

```yaml
# .travis.yml
language: ruby
rvm:
  - 2.7
services:
  - couchbase
before_script:
  - curl -O http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb
  - sudo dpkg -i couchbase-release-1.0-amd64.deb
  - sudo apt-get update
  - sudo apt-get install couchbase-server
  - sudo systemctl start couchbase-server
script:
  - bundle exec rspec
```

This configuration sets up a Ruby environment, installs Couchbase Server, and runs your RSpec tests on each build.

Testing is crucial for ensuring the correctness and reliability of your CouchbaseOrm-based application. By writing comprehensive tests for your models, queries, and interactions with Couchbase, you can catch bugs early, prevent regressions, and maintain a high-quality codebase.

In the next section, we'll explore advanced topics in CouchbaseOrm, such as transactions, concurrency, and error handling.
