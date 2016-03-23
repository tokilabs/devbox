require_relative '../../helpers/serverspec/spec_helper'

describe 'wrap-nginx::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'installs nginx service' do
    describe service('nginx') do
      it { should be_installed }
    end
  end
end
