#
# Cookbook Name:: twemproxy
# Recipe:: configure
#
# Copyright 2015, Mindera

TWEMPROXY = node['twemproxy']
TWEMPROXY_CONFIG = node['twemproxy']['config']

if TWEMPROXY_CONFIG.nil?
  fail "The twemproxy configuration hash must exist - use node['twemproxy']['config'] to set it!"
end

twemproxy_configure 'twemproxy' do
  config TWEMPROXY_CONFIG
  update_config TWEMPROXY['update_config']
  config_dir TWEMPROXY['config_dir']
  log_dir TWEMPROXY['log_dir']
  pid_dir TWEMPROXY['pid_dir']
  user TWEMPROXY['user']
  group TWEMPROXY['group']
end
