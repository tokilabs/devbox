#
# Cookbook Name:: doare-nginx
# Recipe:: wordpress_site
#
# Copyright (c) 2016 Doare, Inc, All Rights Reserved.

site = node['nginx']['wpsite']

if site.install_certs
  include_recipe 'doare-nginx::certs'
end

directory '/etc/nginx/global/wordpress' do
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end

globalConfs = %w(
  restrictions.conf
  wordpress/restrictions.conf
  wordpress/super-cache.conf
  wordpress/w3-total-cache-ms-domains.conf
  wordpress/w3-total-cache-ms-subdir.conf
  wordpress/w3-total-cache-single.conf
  wordpress/w3-total-cache.conf
)

globalConfs.each do |path|
  template "/etc/nginx/global/#{path}" do
    source "nginx/global/#{path}"
    owner 'root'
    group 'root'
    mode '0644'
  end
end

directory "/etc/nginx/sites-available/#{site.name}" do
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end

siteConfs = %w(
  force-https.conf
  http-and-https.conf
  http.conf
  https.conf
  php-fpm.conf
  server-main.conf
  wordpress.conf
)

siteConfs.each do |file|
  template "/etc/nginx/sites-available/#{site.name}/#{file}" do
    source "nginx/site/#{file}.erb"
    #verify 'nginx -t -c %{path}'
    owner 'root'
    group 'root'
    mode '0644'
    variables ({ site: site })
  end
end

link "/etc/nginx/sites-available/#{site.domain}" do
  to "/etc/nginx/sites-available/#{site.name}/#{site.mode}.conf"
end

if site.default
  template "/etc/nginx/sites-available/default" do
    source 'nginx/redir-to-site.erb'
    #verify 'nginx -t -c %{path}'
    owner 'root'
    group 'root'
    mode '0644'
    variables ({ site: site })
  end

  bash 'Enabling default site' do
    code 'nxensite default'
  end
end

bash "Enabling #{site.domain} site" do
  code "nxensite #{site.domain}"
end
