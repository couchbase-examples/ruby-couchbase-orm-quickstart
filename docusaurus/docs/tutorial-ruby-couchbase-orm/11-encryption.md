# Encryption

CouchbaseOrm provides built-in support for encrypting sensitive data stored in your Couchbase documents. Encryption allows you to protect confidential information, such as personal data or financial details, by encrypting the values before storing them in the database and decrypting them when retrieving the data.

## 11.1. Configuring Encryption

To enable encryption in CouchbaseOrm, you need to configure the encryption settings in your application. CouchbaseOrm uses the `ActiveSupport::MessageEncryptor` class from the Rails framework for encryption.

First, generate a secret key that will be used for encryption and decryption. You can generate a random key using the following command:

```bash
ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"
```

This command generates a 128-character hexadecimal string that you can use as the encryption key.

Next, configure the encryption settings in your application's initialization file or environment-specific configuration file.

```ruby
CouchbaseOrm.configure do |config|
  config.encryption_key = 'your_generated_encryption_key'
end
```

Replace `'your_generated_encryption_key'` with the actual encryption key you generated.

## 11.2. Encrypted Attributes

To mark an attribute as encrypted, you can use the `:encrypted` type when defining the attribute in your model.

```ruby
class User < CouchbaseOrm::Base
  attribute :name, :string
  attribute :email, :string
  attribute :ssn, :encrypted
end
```

In this example, the `ssn` attribute is marked as encrypted. CouchbaseOrm will automatically encrypt the value of `ssn` before storing it in the Couchbase document and decrypt it when retrieving the document.

You can assign values to encrypted attributes just like any other attribute.

```ruby
user = User.new
user.name = 'John Doe'
user.email = 'john@example.com'
user.ssn = '123-45-6789'
user.save
```

When the document is saved, CouchbaseOrm encrypts the value of `ssn` using the configured encryption key.

## 11.3. Querying Encrypted Attributes

Querying encrypted attributes requires special handling because the encrypted values are stored in the database.

CouchbaseOrm provides a `where_encrypted` method that allows you to query encrypted attributes.

```ruby
encrypted_users = User.where_encrypted(ssn: '123-45-6789')
```

The `where_encrypted` method encrypts the provided value and performs the query using the encrypted value. It returns the matching documents with the encrypted attributes decrypted.

Note that querying encrypted attributes may have performance implications since the values need to be encrypted before querying and decrypted after retrieval.

## 11.4. Encryption Algorithm

By default, CouchbaseOrm uses the AES-256-GCM encryption algorithm provided by the `ActiveSupport::MessageEncryptor` class. This algorithm is secure and widely used for symmetric encryption.

If you need to use a different encryption algorithm or customize the encryption settings, you can configure the `ActiveSupport::MessageEncryptor` instance used by CouchbaseOrm.

```ruby
CouchbaseOrm.configure do |config|
  config.encryption_options = {
    cipher: 'aes-256-cbc',
    key: 'your_encryption_key',
    iv: 'your_initialization_vector'
  }
end
```

In this example, we configure CouchbaseOrm to use the AES-256-CBC encryption algorithm with a custom encryption key and initialization vector.

## 11.5. Encryption and Decryption Process

When an encrypted attribute is assigned a value, CouchbaseOrm encrypts the value using the configured encryption key and algorithm. The encrypted value is then stored in the Couchbase document.

When retrieving a document with encrypted attributes, CouchbaseOrm automatically decrypts the encrypted values using the same encryption key and algorithm. The decrypted values are then accessible through the model's attributes.

It's important to keep the encryption key secure and protect it from unauthorized access. If the encryption key is compromised, the encrypted data can be decrypted by anyone who obtains the key.

## 11.6. Considerations and Best Practices

When using encryption in CouchbaseOrm, consider the following best practices:

- Keep the encryption key secure and protect it from unauthorized access. Store the key securely and avoid committing it to version control systems.
- Use strong and unique encryption keys for each environment (development, staging, production) to prevent cross-environment access to encrypted data.
- Be cautious when querying encrypted attributes as it may impact performance. Consider indexing encrypted attributes separately if frequent querying is required.
- If you need to search or query encrypted data frequently, consider using a separate encrypted search index or a dedicated encryption service.
- Ensure that the encryption key is properly rotated and managed. If the encryption key is compromised, you should generate a new key and re-encrypt the affected data.

Encryption is a powerful tool for protecting sensitive data, but it should be used judiciously. Encrypting every attribute in your model may not be necessary or practical. Focus on encrypting the most sensitive and confidential data while balancing the trade-offs between security and performance.

In the next section, we'll explore logging in CouchbaseOrm and how you can configure and customize logging to monitor and debug your application.
