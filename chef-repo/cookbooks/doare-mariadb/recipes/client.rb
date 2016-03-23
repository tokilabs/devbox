#
# Cookbook Name:: doare-mariadb
# Recipe:: client
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'doare-base::default'

db = node.db

if db.version == '10.0' or not db.prefer_os_package
  include_recipe 'doare-mariadb::repository'
end

packages = ["mariadb-client-#{node['db']['version']}"]

if node['db']['client_development_files']
  packages += ['libmariadbclient-dev']
end

package 'Mariadb packages' do
  package_name packages
end

mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mariadb
  action :install
end
