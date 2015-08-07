#
# Cookbook Name:: twemproxy
# Recipe:: default
#
# Copyright 2015, Mindera
#

TWEMPROXY = node['twemproxy']

twemproxy_install 'twemproxy' do
  mirror TWEMPROXY['mirror']
  version TWEMPROXY['version']
  file_name TWEMPROXY['file_name']
  artifact_type TWEMPROXY['artifact_type']
end
