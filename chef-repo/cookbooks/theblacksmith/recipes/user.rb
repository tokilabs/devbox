#
# Cookbook Name:: theblacksmith
# Recipe:: user
#
# Copyright (c) 2016 The Blacksmith (a.k.a. Saulo Vallory), All Rights Reserved.

#
# Cookbook Name:: doare-base
# Recipe:: users
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'locale'

package "Install required packages" do
  package_name ['git', 'zsh', 'expect', 'libssl-dev', 'ruby-shadow']
end

#chef_gem 'ruby-shadow'

user = node.user.login
ssh_dir = "/home/#{user}/.ssh"
githubDeploy = data_bag_item('secrets', "github-deploy")
userSecrets = data_bag_item('secrets', user)

# Set hostname
file '/etc/hostname' do
  content node['hostname']
  only_if { node['hostname'] != '' }
end

bash "Update hostname" do
  code <<-CODE
    hostname #{node['hostname']}
    echo "127.0.0.1 #{node['hostname']}" >> /etc/hosts
  CODE
  only_if { node['hostname'] != '' }
end

user user do
  comment 'The Blacksmith default user'
  manage_home true
  home "/home/#{user}"
  shell '/bin/zsh'
  password '$1$iI.BJPVR$oij6ciQGyGR/W/8XIKTm8/'
  action :create
end

# Add it to sudoers
file "/etc/sudoers.d/#{user}" do
  content "#{user} ALL=(ALL) NOPASSWD:ALL"
  mode '0440'
end

directory ssh_dir do
  owner user
  group user
  mode '0755'
  action :create
end

# copy ssh private key
file "#{ssh_dir}/id_rsa" do
  content userSecrets['key']
  owner user
  group user
  mode '0600'
  action :create
end

# copy ssh private key
file "#{ssh_dir}/github-deploy" do
  content githubDeploy['key']
  owner user
  group user
  mode '0600'
  action :create
end

# copy ssh public key
cookbook_file "#{ssh_dir}/id_rsa.pub" do
  source 'id_rsa.pub'
  owner user
  group user
  mode '0644'
  action :create
end

# Add ssh pub key to authorized keys
cookbook_file "#{ssh_dir}/authorized_keys" do
  source 'id_rsa.pub'
  owner user
  group user
  mode '0644'
  action :create
end

# add ssh config
cookbook_file "#{ssh_dir}/config" do
  source 'ssh_config'
  owner user
  group user
  mode '0644'
  action :create
end

# Install git-crypt
bash "Install git-crypt" do
  creates "/usr/local/bin/git-crypt"
  code <<-CODE
    cd ~
    wget https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.5.0.tar.gz
    tar -xzf git-crypt-0.5.0.tar.gz
    cd git-crypt-0.5.0
    make
    make install
    cd ..
    rm -rf git-crypt-0.5.0*
  CODE
end

# Checkout my dotfiles
git "/home/#{user}/.dotfiles" do
  action :sync
  repository "git@github.deploy:svallory/dotfiles.git"
  revision 'master'
  user user
  environment ({
    :HOME => "/home/#{user}"
  })
end

# Run .dotfiles install
bash 'Install dofiles' do
  cwd "/home/#{user}"
  code "/home/#{user}/.dotfiles/install.linux"
  user user
  environment ({
    :HOME => "/home/#{user}"
  })
  creates "/home/#{user}/.nanorc"
end

# clean up
bash 'Cleaning up' do
  cwd "/home/#{user}/.dotfiles"
  code <<-CODE
    git remote remove origin
    git remote add origin git@github.com:svallory/dotfiles.git
    git checkout master
  CODE
  not_if 'git remote -v | grep github.com'
end
