default['db'] = {
  'version' => '10.0',
  'install_server' => true,
  'install_client' => true,
  'root_password' => '',
  'forbid_remote_root' => true,
  'client_development_files' => true,
  'server_development_files' => true,
  'prefer_os_package' => true,
  'repository_base_url' => 'ftp.igh.cnrs.fr/pub/mariadb/repo',
  'bind_address' => '127.0.0.1'
}

# Version to install (currently 10.0 et 5.5)
# Default: '10.0'
# default['mariadb']['install']['version'] = default['db']['version']

# Whether to install MariaDB default repository or not.
# If you don't have a local repo containing packages, put it to true
# default: false
# default['mariadb']['use_default_repository'] = true

# The http base url to use when installing from default repository
# Default: 'ftp.igh.cnrs.fr/pub/mariadb/repo'
# default['mariadb']['apt_repository']['base_url'] = 'ftp.igh.cnrs.fr/pub/mariadb/repo'

# Indicator for preferring use packages shipped by running os
# Default: false
# override['mariadb']['install']['prefer_os_package'] = default['db']['prefer_os_package']

# Whether to activate root remote access
# Default: true
# default['mariadb']['forbid_remote_root'] = true

# Whether to allow the recipe to change root password after the first install
# Default: false
# default['mariadb']['allow_root_pass_change'] = false

# Whether to install development files in client recipe
# Default: true
# default['mariadb']['client']['development_files'] = default['db']['client_development_files']

# Local root password
# Default: ''
# default['mariadb']['server_root_password'] = default['db']['root_password']
