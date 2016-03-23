#
# Cookbook Name:: doare-base
# Recipe:: private-networking
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

log "Search" do
  message "Searching: #{node['private_networking']['nodes_selector']} AND NOT name:#{node['name']}"
end

nodes = search(:node, "chef_environment:production")

content = ""
nodes.each do |n|
  n.network.interfaces[n.default.private_networking.iface].addresses.each do |addr,attrs|
    if attrs.family == n.default.private_networking.addr_family
      content += "#{addr} #{n.name}\\n"
    end
  end
end

bash 'Append other nodes IPs to /etc/hosts' do
  code <<-CODE
    echo "#{content}" >> /etc/hosts
  CODE
end
