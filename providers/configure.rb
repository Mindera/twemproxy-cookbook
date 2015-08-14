#
# Cookbook Name:: twemproxy
# Provider:: configure
#
# Copyright 2015, Mindera
#

action :run do
  create_user
  create_dirs
  configure
end

def create_user
  Chef::Log.info 'Creating nutcracker user'

  user new_resource.user do
    system true
    action :create
  end

  group new_resource.group do
    system true
    action :create
  end
end

def create_dirs
  Chef::Log.info 'Creating nutcracker system directories'

  [
    new_resource.config_dir,
    new_resource.log_dir,
    new_resource.pid_dir
  ].each do |dir|
    directory dir do
      owner new_resource.user
      group new_resource.group
      action :create
      recursive true
    end
  end
end

def configure
  Chef::Log.info 'Configuring nutcracker'

  if new_resource.update_config == true
    config_action = :create
  else
    config_action = :create_if_missing
  end

  template "#{new_resource.config_dir}/nutcracker.yml" do
    source 'nutcracker.yml.erb'
    cookbook 'twemproxy'
    owner 'root'
    group 'root'
    action config_action
    variables(
      :config => new_resource.config,
      :update_config => new_resource.update_config
    )
  end

  config_test unless new_resource.update_config == false
end

def config_test
  execute 'test_nutcracker_config' do
    command "nutcracker --test-conf -c #{new_resource.config_dir}/nutcracker.yml"
    returns 0
  end
end
