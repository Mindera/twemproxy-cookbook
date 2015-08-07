#
# Cookbook Name:: twemproxy
# Attribute:: default
#
# Copyright 2015, Mindera
#

# Installation attributes
default['twemproxy']['mirror'] = 'https://github.com/twitter/twemproxy/archive'
default['twemproxy']['version'] = 'v0.4.1'
default['twemproxy']['file_name'] = nil
default['twemproxy']['artifact_type'] = 'tar.gz'

# Configuration attributes
default['twemproxy']['update_config'] = true
default['twemproxy']['config_dir'] = '/etc/nutcracker'
default['twemproxy']['log_dir'] = '/var/log/nutcracker'
default['twemproxy']['pid_dir'] = '/var/run/nutcracker'
default['twemproxy']['user'] = 'nutcracker'
default['twemproxy']['group'] = 'nutcracker'

# Twemproxy config hash to be converted to the yaml config
default_unless['twemproxy']['config'] = nil
