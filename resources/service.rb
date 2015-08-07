#
# Cookbook Name:: twemproxy
# Resource:: service
#
# Copyright 2015, Mindera
#
actions :run,
        :enable,
        :start

default_action :run

attribute :config_dir, :kind_of => String, :default => '/etc/nutcracker'
attribute :log_dir, :kind_of => String, :default => '/var/log/nutcracker'
attribute :pid_dir, :kind_of => String, :default => '/var/run/nutcracker'
attribute :user, :kind_of => String, :default => 'nutcracker'
