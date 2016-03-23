require_relative '../config/developer'

this_dir = File.dirname(__FILE__)

node_name                 CONFIG[:user]
client_key                CONFIG[:secrets][:user]
validation_client_name    "#{CONFIG[:org]}-validator"
validation_key            CONFIG[:secrets][:org]
chef_server_url           "https://api.opscode.com/organizations/#{CONFIG[:org]}"
syntax_check_cache_path   File.join(this_dir, 'syntax_check_cache')
cookbook_path             [File.join(this_dir, '..', 'cookbooks')]
cookbook_copyright        CONFIG[:copyright_owner]
cookbook_license          CONFIG[:license]
cookbook_email            CONFIG[:email]

local_mode                CONFIG[:local_mode]
versioned_cookbooks       CONFIG[:versioned_cookbooks]
chef_zero.enabled         CONFIG[:chef_zero][:enbaled]
chef_zero.port            CONFIG[:chef_zero][:port]

## Configuring generators
#########################

chefdk.generator_cookbook File.join(this_dir, 'generators')

## Amazon AWS
# if config.aws
#   knife[:aws_access_key_id] = ''
#   knife[:aws_secret_access_key] = ''
# end

## Rackspace Cloud
# if config.rackspace
#   knife[:rackspace_api_username] = ''
#   knife[:rackspace_api_key] = ''
# end
