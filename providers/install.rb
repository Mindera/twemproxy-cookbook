#
# Cookbook Name:: twemproxy
# Provider:: install
#
# Copyright 2015, Mindera
#

use_inline_resources

action :run do
  unless twemproxy_version_installed?
    file = new_resource.file_name.nil? ? new_resource.version :  "#{new_resource.file_name}-#{new_resource.version}"
    url = "#{new_resource.mirror}/#{file}.#{new_resource.artifact_type}"

    Chef::Log.info "Installing twemproxy #{new_resource.version} from #{url}"

    install_compile_deps
    download(url)
    build
    install
  end
end

def install_compile_deps
  Chef::Log.info 'Installing build dependencies'

  include_recipe 'build-essential::default'

  # Required but not installed by build-essential
  %w(
    automake
    libtool
  ).each do |pkg|
    package pkg  do
      action :install
    end
  end

  ark 'autoconf' do
    url 'http://ftp.gnu.org/gnu/autoconf/autoconf-2.64.tar.gz'
    path Chef::Config[:file_cache_path]
    action :put
    strip_components 1
  end

  execute 'Install autoconf' do
    cwd "#{Chef::Config[:file_cache_path]}/autoconf"
    command './configure && make && make install'
    only_if { missing_autoconf_2_64? }
  end
end

def download(url)
  Chef::Log.info("Downloading twemproxy from #{url}")

  ark 'twemproxy' do
    url url
    path Chef::Config[:file_cache_path]
    action :put
    strip_components 1
  end
end

def build
  Chef::Log.info('Building twemproxy')

  execute 'Build twemproxy' do
    cwd "#{Chef::Config[:file_cache_path]}/twemproxy"
    command 'autoreconf -vi && ./configure && make'
    # automake depends on autoconf and we end up with 2 autoconf versions installed - we need autoconf 2.64+
    environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
  end
end

def install
  Chef::Log.info('Installing twemproxy')

  execute 'Install twemproxy' do
    cwd "#{Chef::Config[:file_cache_path]}/twemproxy"
    command 'make install'
  end
end

def missing_autoconf_2_64?
  cmd = shell_out!("autoconf --version | head -1 | awk -F ' ' '{print $4}'")
  cmd.stdout.match('2.64').nil?
end

def twemproxy_version_installed?
  if twemproxy_exists?
    cmd =
      shell_out!("nutcracker --version 2&> /dev/stdout | head -1 | awk -F ' ' '{print $3}' | awk -F '-' '{print $2}'")
    !cmd.stdout.match(new_resource.version.tr('v', '')).nil?
  else
    return false
  end
end

def twemproxy_exists?
  ::File.exist?('/usr/local/sbin/nutcracker')
end
