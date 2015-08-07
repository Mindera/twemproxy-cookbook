#
# Cookbook Name:: twemproxy
# Recipe:: default
#
# Copyright 2015, Mindera
#

include_recipe 'twemproxy::install'
include_recipe 'twemproxy::configure'
include_recipe 'twemproxy::service'
