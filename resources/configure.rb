#
# Cookbook Name:: twemproxy
# Resource:: configure
#
# Copyright 2015, Mindera
#
actions :run

default_action :run

attribute :config, :kind_of => Hash, :required => true
attribute :update_config, :kind_of => [TrueClass, FalseClass], :default => true
attribute :config_dir, :kind_of => String, :default => '/etc/nutcracker'
attribute :log_dir, :kind_of => String, :default => '/var/log/nutcracker'
attribute :pid_dir, :kind_of => String, :default => '/var/run/nutcracker'
attribute :user, :kind_of => String, :default => 'nutcracker'
attribute :group, :kind_of => String, :default => 'nutcracker'

