require 'spec_helper'

describe 'twemproxy::default' do
  cached(:chef_run) {
    ChefSpec::Runner.new do |node|
      node.default['twemproxy']['config'] = {}
    end.converge(described_recipe)
  }
  cached(:node) { chef_run.node }

  %w{
    twemproxy::install
    twemproxy::configure
    twemproxy::service
  }.each do |recipe|
    it "include the #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe)
    end
  end
end