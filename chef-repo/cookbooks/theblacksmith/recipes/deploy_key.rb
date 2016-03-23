#
# Cookbook Name:: brazilfoundation
# Recipe:: deploy_key
#

key = node.deploy_key

if not key.source or key.source.empty?
  raise "node.deploy_key.source can not be empty"
end

user = key.user
if not user or user.empty?
  user = false
end

key_dest = "#{key.dest}/#{key.filename}"

def copy_key(src, dest=key_dest, mode=key.mode)
  chown = user ? "chown #{user} #{dest}" : ''
  <<-SHELL
  cp #{src} #{dest}
  #{chown}
  chmod #{mode} #{dest}
  SHELL
end

directory key.dest do
  recursive true
  user user if user
end

case key.source.to_s
when 'cookbook'
  cookbook_file key_dest do
    source 'deploy_key'
    owner user if user
    mode key.mode
  end

when 'file'
  bash 'Copy deploy keys from client file' do
    code { copy_key(key.file) }
    only_if { ::File.exists?(key.file) }
  end

when 'client_pem'
  bash 'Generate deploy key from /etc/chef/client.pem' do
    code { copy_key('/etc/chef/client.pem') }
    only_if { ::File.exists?('/etc/chef/client.pem') }
  end

when 'attribute'
  Chef::Log.debug("KEY: |"+key[:key].to_s+"|")
  file key_dest do
    content key[:key]
    owner user if user
    mode key.mode
  end
else
  raise "Invalid node.deploy_key.source (#{key.source}) defined. " +
        "Allowed values are :cookbook, :file, :client_pem and :attribute"
end

bash "Generate pub key from #{key_dest}" do
  code { copy_key(key_dest, key_dest+'.pub', '0644') }
  only_if { key.generate_pub_key }
end
