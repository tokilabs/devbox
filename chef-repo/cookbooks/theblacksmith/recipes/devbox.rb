#
# Cookbook Name:: brazilfoundation
# Recipe:: database
#
# Copyright (c) 2016 The Blacksmith (a.k.a. Saulo Vallory), All Rights Reserved.

include_recipe "doare::db"

db = node.db
app = node.app

include_recipe "doare::web"

package 'php5-curl'
package 'php5-imagick'

php_fpm_pool "default" do
  user app.user
  group app.group
  chdir app.path
  listen app['php_fpm_sock']
  action :install
end

magic_shell_environment 'ENV' do
  value node['env']
end

service "nginx" do
  action :restart
end
