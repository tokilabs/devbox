#
# Cookbook Name:: doare-mariadb
# Recipe:: server
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.


db = node.db

if db.version == '10.0' or not db.prefer_os_package
  include_recipe 'doare-mariadb::repository'
end

root_pass = db.root_password == '' ? 'PASS' : db.root_password

# include_recipe "mariadb::server"
bash 'Install mariadb' do
  code <<-BASH
    export DEBIAN_FRONTEND=noninteractive
    sudo debconf-set-selections <<< 'mariadb-server-#{db.version} mysql-server/root_password password #{root_pass}'
    sudo debconf-set-selections <<< 'mariadb-server-#{db.version} mysql-server/root_password_again password #{root_pass}'
  BASH
end

packages = ["mariadb-server-#{db.version}"]

if node['db']['server_development_files']
  packages += ['libmariadbd-dev']
end

package "MariaDB Server #{db.version}" do
  package_name packages
end

bash 'Setting root password' do
  code "mysql -uroot -p#{root_pass} -e \"SET PASSWORD FOR 'root'@'localhost' = PASSWORD('#{db.root_password}');\""
  only_if "mysql -uroot -p#{root_pass}"
end

mariadb_configuration 'Set bind-address' do
  section 'mysqld'
  option 'bind-address' => db.bind_address
  notifies :restart, 'service[mysql]'
end
