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
end

action :enable do
  configure
  enable
end

action :start do
  configure
  start
end

action :restart do
  configure
  restart
end

def configure
  Chef::Log.info 'Configuring nutcracker service'

  template '/etc/init.d/nutcracker' do
    source 'nutcracker.init.erb'
    cookbook 'twemproxy'
    owner 'root'
    group 'root'
    mode '0755'
    variables({
      :conf_dir => new_resource.config_dir,
      :pid_dir => new_resource.pid_dir,
      :log_dir => new_resource.log_dir,
      :user => new_resource.user,
    })
  end
end

def enable
  Chef::Log.info 'Enabling nutcracker service'

  service 'nutcracker' do
    action :enable
  end
end

def start
  Chef::Log.info 'Starting nutcracker service'

  service 'nutcracker' do
    action :start
  end
end

def restart
  Chef::Log.info 'Re-starting nutcracker service'

  service 'nutcracker' do
    action :restart
  end
end
