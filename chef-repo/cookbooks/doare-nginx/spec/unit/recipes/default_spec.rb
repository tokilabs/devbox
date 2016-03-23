#
# Cookbook Name:: wrap-nginx
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require_relative '../../spec_helper'

describe 'wrap-nginx::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'makes nginx service available' do
      expect { chef_run }.to start_service('nginx')
    end
  end
end
