#
# Cookbook Name:: doare-base
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'doare-base::packages' do
  context 'When all attributes are default, on an unspecified platform' do
    let :chef_run do
      ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        file_cache_path: '/var/tmp'
      ) do |node|
        # set attributes here
        # node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'installs commonly used packages' do
      expect(chef_run).to install_package('Install packages')
        .with(package_name: [
          'curl',
          'unzip',
          'multitail',
          'wget',
          'zsh'
        ])
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
