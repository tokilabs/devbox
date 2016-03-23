default['nginx']['wpsite'] = {
  name: 'default',
  domain: '*',
  http_port: '80',
  root: '/var/www/public',
  # mode: http, https, force-https, http-and-https
  mode: 'force-https',
  force_non_www: true,
  default: true,
  # certs sent to the client in SERVER HELLO are concatenated in ssl_certificate
  install_certs: true,
  cert: '/etc/ssl/certs/cert.pem',
  cert_key: '/etc/ssl/certs/privkey.pem',
  chain: '/etc/ssl/certs/chain.pem',
  # verify chain of trust of OCSP response using Root CA and Intermediate certs
  fullchain: '/etc/ssl/certs/fullchain.pem',
  # Diffie-Hellman parameter for DHE ciphersuites, recommended 2048 bits
  dhparam: '/etc/ssl/certs/dhparam.pem',
  # name servers used to resolve names of upstream servers into addresses
  resolver: '127.0.0.1',
  upstream: {
    name: 'phpfpm',
    server: 'unix:/var/run/php5-fpm-sample.sock'
  },
  cache_plugin: '',
  max_body_size: '2m'
}

default['nginx']['cert'] = nil
default['nginx']['cert_key'] = nil
default['nginx']['log_format'] = 'combined'
default['nginx']['log_dir'] = '/var/log/nginx'
default['nginx']['min_instances'] = 2
#default['nginx']['max_body_size'] = 512
default['nginx']['redirect_to_https'] = false
default['nginx']['http'] = true

# Whether nginx is installed from packages or from source.
default['nginx']['install_method'] = 'package'

# Enable the default site
default['nginx']['default_site_enabled'] = false

###
### Conf template
###

# The source template to use when creating the nginx.conf.
# node['nginx']['conf_template']

# The cookbook where node['nginx']['conf_template'] resides.
# node['nginx']['conf_cookbook']

###
### Logs
###

# Location for Nginx logs.
# node['nginx']['log_dir']

# Permissions for Nginx logs folder.
# node['nginx']['log_dir_perm']

# Set to a string of additional options to be appended to the access log directive
# node['nginx']['access_log_options']

# Set to a string of additional options to be appended to the error log directive
# node['nginx']['error_log_options'] -

###
### Permissions
###

# User that Nginx will run as.
# node['nginx']['user']

# Group for Nginx.
# node['nginx']['group]

###
### Other configurations
###

# Used for config value of client_body_buffer_size.
# node['nginx']['client_body_buffer_size']

# Specifies the maximum accepted body size of a client request, as indicated by the request header Content-Length.
# node['nginx']['client_max_body_size']

# a Hash of key/values to nginx configuration.
default['nginx']['extra_configs'] = {}

###
### Rate Limiting
###

# Set to true to enable rate limiting (limit_req_zone in nginx.conf)
# node['nginx']['enable_rate_limiting']

# Sets the zone in limit_req_zone.
# node['nginx']['rate_limiting_zone_name']

# Sets the backoff time for limit_req_zone.
# node['nginx']['rate_limiting_backoff']

# Set the rate limit amount for limit_req_zone.
# node['nginx']['rate_limit']
