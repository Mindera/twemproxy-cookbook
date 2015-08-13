require 'spec_helper'

describe 'twemproxy::install' do
  cached(:chef_run) {
    ChefSpec::Runner.new do |node|
      node.default['twemproxy']['config'] = {}
    end.converge(described_recipe)
  }
  cached(:node) { chef_run.node }

  it 'install twemproxy using the provider' do
    expect(chef_run).to run_twemproxy_install('twemproxy')
  end
end