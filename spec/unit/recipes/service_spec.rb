require 'spec_helper'

describe 'twemproxy::service' do
  cached(:chef_run) {
    ChefSpec::Runner.new do |node|
      node.default['twemproxy']['config'] = {}
    end.converge(described_recipe)
  }
  cached(:node) { chef_run.node }

  it 'defines the twemproxy service using the provider' do
    expect(chef_run).to run_twemproxy_service('twemproxy')
  end
end