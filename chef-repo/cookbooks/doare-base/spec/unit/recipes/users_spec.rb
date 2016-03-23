#
# Cookbook Name:: doare-base
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'doare-base::users' do
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

    it 'creates www-data group' do
      expect(chef_run).to create_group('www-data')
    end

    it 'creates app user' do
      expect(chef_run).to create_user('app').with(shell: '/bin/zsh')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When ssh keys are provided' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set['authorized_keys'] = {
          :app => [
            'ssh-rsa key1',
            'ssh-rsa key2'
          ],
          :root => [
            'ssh-rsa key2',
            'ssh-rsa key3'
          ]
        }
      end.converge(described_recipe)
    end

    it 'adds the ssh keys to [user]/.ssh/authorized_keys' do
      expect(chef_run).to render_file('/home/app/.ssh/authorized_keys')
        .with_content(/ssh-rsa key1/)
        .with_content(/ssh-rsa key2/)

      expect(chef_run).to render_file('/root/.ssh/authorized_keys')
        .with_content(/ssh-rsa key2/)
        .with_content(/ssh-rsa key3/)
    end
  end
end
