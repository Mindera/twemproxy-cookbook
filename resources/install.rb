#
# Cookbook Name:: twemproxy
# Resource:: install
#
# Copyright 2015, Mindera
#

actions :run

default_action :run

attribute :mirror, :kind_of => String, :default => 'https://github.com/twitter/twemproxy/archive'
attribute :version, :kind_of => String, :default => 'v0.4.1'
attribute :file_name, :kind_of => String, :default => nil
attribute :download_dir, :kind_of => String, :default => Chef::Config[:file_cache_path]
attribute :artifact_type, :kind_of => String, :default => 'tar.gz'
