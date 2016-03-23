require_relative 'spec_helper'

describe service('mysql') do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it { should be_enabled }
  it { should be_running }
end

describe package('mariadb-client-5.5') do
  it { should be_installed }
end

describe package('mariadb-client-core-5.5') do
  it { should be_installed }
end
