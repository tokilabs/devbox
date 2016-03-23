Overview
========

This is the place where Doare cookbook, roles, config files and other artifacts for managing our servers with Chef will live.

Other cookbooks which the Doare cookbook depends on are managed through [Berkshelf](http://berkshelf.com)

Repository Directories
======================

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

* `cookbooks/` - Cookbooks we create
* `cookbooks/doare` - The doare cookbook
* `cookbooks/wrap-*` - Wrapper cookbooks for configuring applications
* `data_bags/` - The data bags and items in .json
* `roles/` - Roles in .rb or .json
* `environments/` - The environments in .rb or .json

Configuration
=============

1. If you are a new developer, make sure you have a `USER` or `OPSCODE_USER` variable set to your username on Opscode.

2. Copy your authentication key (user.pem), doare validation key (doare-validator.pem) and the `encrypted_data_bag_secret` files to `config/secrets/`

3. Copy `config/developer.example.rb` to `config/developer.rb`

The config file, `.chef/knife.rb` is a repository specific configuration file for knife. It's shared by all developers. Some of knife's configuration can be changed at `config/developer.rb`.

Next Steps
==========

Read the README file in each of the subdirectories for more information about what goes in those directories.
