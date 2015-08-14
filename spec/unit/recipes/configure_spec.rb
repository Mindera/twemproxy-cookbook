require 'spec_helper'

describe 'twemproxy::configure' do
  cached(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.default['twemproxy']['config'] = {}
    end.converge(described_recipe)
  end
  cached(:node) { chef_run.node }

  it 'configure twemproxy using the provider' do
    expect(chef_run).to run_twemproxy_configure('twemproxy')
  end
end
