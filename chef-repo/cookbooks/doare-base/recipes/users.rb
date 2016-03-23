#
# Cookbook Name:: doare-base
# Recipe:: users
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

app = node.app

group app.group do
  action :create
  append true
end

user app.user do
  comment 'The user which runs the app'
  gid app.group
  manage_home true
  home "/home/#{app.user}"
  shell '/bin/zsh'
  action :create
end

node.authorized_keys.each do |user, keys|
  if keys.length > 0 and node['etc']['passwd'][user]
    user = app.user if user == :app
    ssh_dir = if user == 'root' then '/root/.ssh' else "/home/#{user}/.ssh" end

    # Create .ssh dir for app user
    directory ssh_dir do
      owner user
      mode '0755'
      action :create
    end

    # ssh_keys = keys.join("\\n")
    # file "#{ssh_dir}/authorized_keys" do
    #   sensitive true
    #   content ssh_keys
    #   owner user
    #   mode '0600'
    # end

    # NÃO FUNFOU NO VAGRANT
    keys.each do |key|
      bash "#{ssh_dir}/authorized_keys" do
        user user
        code <<-EOF
          echo "#{key}" >> "#{ssh_dir}/authorized_keys"
        EOF
        not_if "grep -q '#{key.split[1]}' #{ssh_dir}/authorized_keys", :user => user
      end
    end
  end
end
