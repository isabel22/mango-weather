# Load the Rails application.
require_relative 'application'

secret_file_path = File.expand_path('./config/mango_secrets.yml')
SECRETS = YAML.load_file("#{secret_file_path}")

# Initialize the Rails application.
Rails.application.initialize!
