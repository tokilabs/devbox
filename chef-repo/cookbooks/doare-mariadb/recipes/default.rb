#
# Cookbook Name:: doare-mariadb
# Recipe:: default
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'doare-base::default'

if node['db']['install_server']
  include_recipe "doare-mariadb::server"
end

if node['db']['install_client']
  include_recipe "doare-mariadb::client"
end

service 'mysql' do
  action :start
end
