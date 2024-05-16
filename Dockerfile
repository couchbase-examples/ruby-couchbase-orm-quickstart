# Use the official Ruby 3.0.0 image as the base image
FROM ruby:3.3.0

# Install essential Linux packages
RUN apt-get update -qq && \
    apt-get install -y nodejs npm cmake && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory in the container
WORKDIR /app

# Install Rails gem with version 7.1
RUN gem install rails -v '7.1'

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install project dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]