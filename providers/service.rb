#
# Cookbook Name:: twemproxy
# Provider:: service
#
# Copyright 2015, Mindera
#

action :run do
  configure
  enable
  restart

  new_resource.updated_by_last_action(true)
end

action :enable do
  configure
  enable

  new_resource.updated_by_last_action(true)
end

action :start do
  configure
  start

  new_resource.updated_by_last_action(true)
end

action :restart do
  configure
  restart

  new_resource.updated_by_last_action(true)
end

def configure
  Chef::Log.info 'Configuring nutcracker service'

  template '/etc/init.d/nutcracker' do
    source 'nutcracker.init.erb'
    cookbook 'twemproxy'
    owner 'root'
    group 'root'
    mode '0755'
    variables(
      :conf_dir => new_resource.config_dir,
      :pid_dir => new_resource.pid_dir,
      :log_dir => new_resource.log_dir,
      :user => new_resource.user
    )
  end
end

def enable
  Chef::Log.info 'Enabling nutcracker service'

  service_resource(:enable)
end

def start
  Chef::Log.info 'Starting nutcracker service'

  service_resource(:start)
end

def restart
  Chef::Log.info 'Re-starting nutcracker service'

  service_resource(:restart)
end

def service_resource(action)
  service 'nutcracker' do
    action action
  end
end
