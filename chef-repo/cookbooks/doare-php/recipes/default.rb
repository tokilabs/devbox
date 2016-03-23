#
# Cookbook Name:: doare-php
# Recipe:: default
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'php'

package "php5-mysqlnd" do
  action :install
end
