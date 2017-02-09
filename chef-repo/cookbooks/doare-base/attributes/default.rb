# NOT WORKING
default['packages'] = []

default['private_networking']['nodes_selector'] = 'chef_environment:production'
default['private_networking']['iface'] = 'eth0'
default['private_networking']['addr_family'] = 'inet'

default['app'] = {
  'user' => 'app',
  'group' => 'www-data'
}

default['authorized_keys'] = {
  # example
  # "app": [
  #  "ssh-rsa AAAA..."
  # ]
}

# The value for LANG
# Default: "en_US.utf8"
default[:locale][:lang] = "en_US.utf8"

# The value for LC_ALL
# Default: "en_US.utf8"
default[:locale][:lc_all] = "en_US.utf8"
