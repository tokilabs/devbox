#
# Cookbook Name:: doare-nginx
# Recipe:: certs
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

cert = data_bag_item('secrets', 'cert')
site = node['nginx']['wpsite']

file site.cert do
  content cert['cert']
  mode '0644'
  user 'root'
end

file site.cert_key do
  content cert['key']
  mode '0644'
  user 'root'
end

file site.chain do
  content cert['chain']
  mode '0644'
  user 'root'
end

file site.fullchain do
  content cert['fullchain']
  mode '0644'
  user 'root'
end

file site.dhparam do
  content cert['dhparam']
  mode '0644'
  user 'root'
end
