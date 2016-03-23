name             'doare-mariadb'
maintainer       'Doare, Inc.'
maintainer_email 'devs@doare.org'
license          'All rights reserved'
description      'Installs/Configures wrap-php'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'

depends 'doare-base'
depends 'mariadb', '~> 0.3.1'
depends 'mysql2_chef_gem', '~> 1.0'
