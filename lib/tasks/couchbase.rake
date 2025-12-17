# frozen_string_literal: true

namespace :couchbase do
  desc 'Setup required Couchbase indexes for the application'
  task setup_indexes: :environment do
    puts '=== Setting up Couchbase indexes ==='

    # Get cluster connection from any model (they all share the same cluster)
    cluster = Airline.cluster
    bucket_name = Airline.bucket.name

    puts "Target bucket: #{bucket_name}"

    # Define all required indexes based on N1QL queries in models
    indexes = [
      {
        name: 'idx_type',
        fields: ['type'],
        description: 'Index on type field for all document queries'
      },
      {
        name: 'idx_type_country',
        fields: ['type', 'country'],
        where: "type = 'airline'",
        description: 'Index for airline queries by country (Airline.list_by_country_or_all)'
      },
      {
        name: 'idx_type_destinationairport',
        fields: ['type', 'destinationairport'],
        where: "type = 'route'",
        description: 'Index for route queries by destination airport (Airline.to_airport)'
      },
      {
        name: 'idx_type_sourceairport_stops',
        fields: ['type', 'sourceairport', 'stops'],
        where: "type = 'route'",
        description: 'Index for route queries by source airport and stops (Route.direct_connections)'
      },
      {
        name: 'idx_type_airlineid',
        fields: ['type', 'airlineid'],
        where: "type = 'airline'",
        description: 'Index for airline queries by airline ID (Airline.to_airport join)'
      }
    ]

    created_count = 0
    skipped_count = 0
    failed_indexes = []

    indexes.each do |index_def|
      begin
        puts "\nCreating index: #{index_def[:name]}"
        puts "  Description: #{index_def[:description]}"

        # Build the CREATE INDEX query with IF NOT EXISTS for idempotency
        query = build_create_index_query(bucket_name, index_def)
        puts "  Query: #{query}"

        # Execute the query
        cluster.query(query)

        # If no error, index is ready
        created_count += 1
        puts "  \u2713 Index created or already exists"

      rescue Couchbase::Error::IndexExists => e
        # This shouldn't happen with IF NOT EXISTS, but handle it anyway
        puts "  \u2299 Index already exists (skipped)"
        skipped_count += 1
      rescue Couchbase::Error::CouchbaseError => e
        puts "  \u2717 Failed: #{e.message}"
        failed_indexes << { name: index_def[:name], error: e.message }
      rescue StandardError => e
        puts "  \u2717 Unexpected error: #{e.message}"
        failed_indexes << { name: index_def[:name], error: e.message }
      end
    end

    # Print summary
    puts "\n=== Index Setup Summary ==="
    puts "Total indexes: #{indexes.count}"
    puts "Successfully processed: #{created_count}"
    puts "Skipped (already existed): #{skipped_count}"
    puts "Failed: #{failed_indexes.count}"

    if failed_indexes.any?
      puts "\n=== Failed Indexes ==="
      failed_indexes.each do |failed|
        puts "  - #{failed[:name]}: #{failed[:error]}"
      end

      # Exit with error code for CI
      exit 1
    else
      puts "\n\u2713 All indexes are ready!"
    end
  rescue Couchbase::Error::AuthenticationFailure => e
    puts "\n\u2717 Authentication failed: #{e.message}"
    puts "Please verify your Couchbase credentials:"
    puts "  - DB_USERNAME environment variable"
    puts "  - DB_PASSWORD environment variable"
    exit 1
  rescue Couchbase::Error::CouchbaseError => e
    puts "\n\u2717 Couchbase connection error: #{e.message}"
    puts "Please check your connection settings:"
    puts "  - DB_CONN_STR environment variable"
    puts "  - DB_USERNAME environment variable"
    puts "  - DB_PASSWORD environment variable"
    puts "  - Network connectivity to Couchbase cluster"
    exit 1
  rescue StandardError => e
    puts "\n\u2717 Unexpected error: #{e.class} - #{e.message}"
    puts e.backtrace.first(5).join("\n")
    exit 1
  end

  desc 'Drop all application indexes (use with caution!)'
  task drop_indexes: :environment do
    puts '=== Dropping Couchbase indexes ==='
    puts 'WARNING: This will drop all application indexes!'

    unless ENV['FORCE_DROP'] == 'true'
      print 'Are you sure? (yes/no): '
      confirmation = $stdin.gets.chomp
      unless confirmation.downcase == 'yes'
        puts 'Aborted.'
        exit 0
      end
    end

    cluster = Airline.cluster
    bucket_name = Airline.bucket.name

    index_names = [
      'idx_type',
      'idx_type_country',
      'idx_type_destinationairport',
      'idx_type_sourceairport_stops',
      'idx_type_airlineid'
    ]

    dropped_count = 0
    not_found_count = 0

    index_names.each do |index_name|
      begin
        query = "DROP INDEX `#{bucket_name}`.`#{index_name}`"
        cluster.query(query)
        puts "  \u2713 Dropped index: #{index_name}"
        dropped_count += 1
      rescue Couchbase::Error::IndexNotFound
        puts "  \u2299 Index not found (already dropped): #{index_name}"
        not_found_count += 1
      rescue StandardError => e
        puts "  \u2717 Failed to drop #{index_name}: #{e.message}"
      end
    end

    puts "\n=== Drop Summary ==="
    puts "Dropped: #{dropped_count}"
    puts "Not found: #{not_found_count}"
    puts "\n\u2713 Index cleanup complete!"
  end

  desc 'List all indexes in the bucket'
  task list_indexes: :environment do
    puts '=== Couchbase Indexes ==='

    cluster = Airline.cluster
    bucket_name = Airline.bucket.name

    query = "SELECT idx.* FROM system:indexes AS idx WHERE idx.keyspace_id = '#{bucket_name}' ORDER BY idx.name"
    result = cluster.query(query)

    if result.rows.empty?
      puts "No indexes found in bucket '#{bucket_name}'"
    else
      puts "Indexes in bucket '#{bucket_name}':\n"
      result.rows.each do |row|
        puts "  Name: #{row['name']}"
        puts "    State: #{row['state']}"
        puts "    Type: #{row['using']}"
        puts "    Keys: #{row['index_key']}"
        puts "    Condition: #{row['condition']}" if row['condition']
        puts ""
      end
      puts "Total: #{result.rows.count} indexes"
    end
  rescue StandardError => e
    puts "\u2717 Error listing indexes: #{e.message}"
    exit 1
  end

  # Private helper method to build CREATE INDEX query
  def build_create_index_query(bucket_name, index_def)
    query = "CREATE INDEX IF NOT EXISTS `#{index_def[:name]}` ON `#{bucket_name}`"

    # Add fields
    fields = index_def[:fields].map { |f| "`#{f}`" }.join(', ')
    query += "(#{fields})"

    # Add WHERE clause if present
    query += " WHERE #{index_def[:where]}" if index_def[:where]

    query
  end
end
