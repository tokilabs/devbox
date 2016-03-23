# -*- mode: ruby -*-
# vi: set ft=ruby :

# require_relative 'config/developer'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  #config.vm.synced_folder "src", "/vagrant/src"

  #config.berkshelf.berksfile_path = File.join(File.dirname(__FILE__), 'deploy', 'chef-repo', 'cookbooks', 'gain1', 'Berksfile')
  config.berkshelf.enabled = true

  developerKey = IO.read(File.join(ENV['HOME'],'.ssh','id_rsa.pub'))

  #
  #           WEB
  #
  config.vm.define :devbox do |devbox|
    devbox.vm.hostname = 'devbox.vm'
    devbox.vm.network "private_network", ip: "10.0.0.2"

    devbox.vm.synced_folder "../src", "/var/www"

    devbox.vm.provider "virtualbox" do |vb|
      vb.customize ['modifyvm', :id, '--name', "BrazilFoundation-Web"]

      # Don't display the VirtualBox GUI when booting the machine
      vb.gui = false

      # Customize the amount of memory on the VM:
      vb.memory = "1024"

      # Allow symlinks
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end

    devbox.vm.provision :chef_solo do |chef|
      # Uncomment to set chef log level to debug
      #chef.log_level          = "debug"

      chef.cookbooks_path = ["chef-repo/cookbooks"]

      chef.add_recipe "doare::web"
      chef.add_recipe "doare::db"
      chef.add_recipe "theblacksmith::devbox"
      chef.add_recipe "theblacksmith::user"

      chef.data_bags_path = ["chef-repo/data_bags"]
      chef.encrypted_data_bag_secret_key_path = 'chef-repo/.chef/encrypted_data_bag_secret'

      chef.json = {
        :env => 'dev',
        :hostname => 'devbox.vm',
        :user => {
          :name => 'Saulo Vallory',
          :login => 'svallory',
          :email => 'me@saulovallory.com'
        },
        :app => {
          domain: 'devbox.vm',
          checkout_code: false,
          php_fpm_sock: '/var/run/php5-fpm-default.sock'
        },
        :db => {
          :bind_address => '10.0.0.2',
          :root_password => 'sbrubles'
        },
        :authorized_keys => {
          vagrant: [developerKey],
          root: [developerKey],
          bf: [developerKey]
        },
        :deploy_key => {
          :source => :attribute,
          :user => '',
          :key => IO.read(File.join(File.dirname(__FILE__),'keys','developer')),
          :filename => 'id_rsa' # ENV['OPSCODE_USER'] || ENV['USER']
        }
      }
    end
  end
end
