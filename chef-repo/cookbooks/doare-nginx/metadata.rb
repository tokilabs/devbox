name             'doare-nginx'
maintainer       'Doare, Inc.'
maintainer_email 'devs@doare.org'
license          'All rights reserved'
description      'Configures nginx for our web servers'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.4'

depends 'nginx', '~> 2.7.6'
