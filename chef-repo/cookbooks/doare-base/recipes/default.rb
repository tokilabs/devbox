#
# Cookbook Name:: doare-base
# Recipe:: default
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'locale'

include_recipe 'doare-base::packages'

include_recipe 'doare-base::users'
