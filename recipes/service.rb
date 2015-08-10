#
# Cookbook Name:: twemproxy
# Recipe:: service
#
# Copyright 2015, Mindera

TWEMPROXY = node['twemproxy']

twemproxy_service 'twemproxy' do
  config_dir TWEMPROXY['config_dir']
  log_dir TWEMPROXY['log_dir']
  pid_dir TWEMPROXY['pid_dir']
  user TWEMPROXY['user']
end
