#
# Cookbook Name:: doare-base
# Recipe:: packages
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe "apt"

packages = [
  'curl',
  'unzip',
  'multitail',
  'wget',
  'zsh'
]

package 'Install packages' do
  package_name packages

  action :install
end

include_recipe 'build-essential'
