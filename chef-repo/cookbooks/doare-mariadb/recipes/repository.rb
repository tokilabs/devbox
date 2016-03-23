#
# Cookbook Name:: doare-mariadb
# Recipe:: repository
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'doare-base::default'

apt_repository "mariadb-#{node['db']['version']}" do
  uri 'http://' + node['db']['repository_base_url'] + '/' + \
    node['db']['version'] + '/' + node['platform']
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key '0xcbcb082a1bb943db'
end
