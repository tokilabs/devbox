org = '<ORG SHORT NAME>'

secrets_dir = File.join(File.dirname(__FILE__), 'secrets')
user = ENV['OPSCODE_USER'] || ENV['USER']

CONFIG = {
  dir: File.dirname(__FILE__),
  user: user,
  org: org,

  copyright_owner: 'ACME Inc',
  license: 'none',
  email: 'dev@example.org',

  secrets: {
    user: File.join(secrets_dir, user) + '.pem',
    org: File.join(secrets_dir, org) + '-validator.pem',
    data_bag: File.join(secrets_dir, 'encrypted_data_bag_secret')
  },

  chef_zero: {
    enabled: false,
    port: 8889
  },

  # This setting can also set to true by passing --local-mode to knife
  local_mode: false,

  # Append cookbook versions to cookbooks.
  # Set to false to hide cookbook versions: cookbooks/apache.
  # Set to true to show cookbook versions: cookbooks/apache-1.0.0 and/or
  # cookbooks/apache-1.0.1. When this setting is true, `knife download`
  # downloads ALL cookbook versions, which can be useful if a full-fidelity
  # backup of data on the Chef server is required.
  versioned_cookbooks: false,

  cli: {
    editor: ENV['EDITOR'] || 'nano',
    ssh: {
      user: 'vagrant',
      port: '2222',
      identity_file: File.exist?('~/.ssh/id_rsa') ? '~/.ssh/id_rsa' : nil
    },
    # for data bag encrypted items
    secret_file: File.join(config_dir, 'secrets', 'encrypted_data_bag_secret')
  }
}
