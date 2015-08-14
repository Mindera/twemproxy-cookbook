# Twemproxy Cookbook

[![Build Status](https://travis-ci.org/Mindera/twemproxy-cookbook.svg?branch=master)](https://travis-ci.org/Mindera/twemproxy-cookbook)

Chef coookbook to install and manage [Twemproxy](https://github.com/twitter/twemproxy).

## Requirements

None.

## Platforms

 * Centos 6+
 * RedHat 6+

## Usage

This cookbook can be used both by including its recipes and being attribute-driven or simply by calling the available providers within your own cookbook.

## Attributes

### default.rb

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
        <th>Options</th>
        <th>Default</th>
    </tr>
    <tr>
        <td><tt>['twemproxy']['mirror']</tt></td>
        <td>String</td>
        <td>Artifact mirror</td>
        <td>-</td>
        <td><tt>https://github.com/twitter/twemproxy/archive</tt></td>
    </tr>
    <tr>
        <td><tt>['twemproxy']['version']</tt></td>
        <td>String</td>
        <td>Artifact version</td>
        <td>-</td>
        <td><tt>v0.4.1</tt></td>
    </tr>
    <tr>
        <td><tt>['twemproxy']['file_name']</tt></td>
        <td>String</td>
        <td>Artifact name</td>
        <td>Defaults to nil since it fetches from the github archives.</td>
        <td><tt>nil</tt></td>
    </tr>
    <tr>
        <td><tt>['twemproxy']['artifact_type']</tt></td>
        <td>String</td>
        <td>Artifact type</td>
        <td>-</td>
        <td><tt>tar.gz</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['update_config']/tt></td>
        <td>TrueClass/FalseClass</td>
        <td>Manage twemproxy configs after the initial run - you want to disable this is you update configs via sentinels</td>
        <td>-</td>
        <td><tt>true</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['config_dir']/tt></td>
        <td>String</td>
        <td>Config directory</td>
        <td>-</td>
        <td><tt>/etc/nutcracker</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['log_dir']/tt></td>
        <td>String</td>
        <td>Log directory</td>
        <td>-</td>
        <td><tt>/var/log/nutcracker</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['pid_dir']/tt></td>
        <td>String</td>
        <td>PID directory</td>
        <td>-</td>
        <td><tt>/var/run/nutcracker</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['user']/tt></td>
        <td>String</td>
        <td>User to run as</td>
        <td>-</td>
        <td><tt>nutcracker</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['group']/tt></td>
        <td>String</td>
        <td>Group to run as</td>
        <td>-</td>
        <td><tt>nutcracker</tt></td>
    </tr>
    <tr>
        <td><tt><['twemproxy']['config']/tt></td>
        <td>String</td>
        <td>Config hash to be converted as the yaml nutcracker configuration file</td>
        <td>Required - the run will fail if you don't set this attribute - be warned!</td>
        <td><tt>nil</tt></td>
    </tr>
</table>

## Recipes

All of this cookbook recipes use the available providers under the hood as described below in the providers section.

### default.rb

Installs, configures and enable/starts the twemproxy service.

### install.rb

Install twemproxy by compiling it from a source artifact.

### configure.rb

Configure twemproxy by doing all the system required tasks (create users, create directories, etc.) and build the yaml configuration file.

### service.rb

Set twemproxy as a service and enable/start it.

### Example

Add the `twemproxy` cookbook as a dependency:

```ruby
depends 'twemproxy'
```

Set a twemproxy config as:

```ruby
default['twemproxy']['config'] = {
  'default' => {
    'listen' => '0.0.0.0:6379',
    'hash' => 'fnv1a_64',
    'distribution' => 'ketama',
    'auto_eject_hosts' => false,
    'redis' => true,
    'preconnect' => true,
    'server_retry_timeout' => 2000,
    'server_failure_limit' => 1,
    'servers' => [
      '172.31.254.103:6380:1 redis_1',
    ]
  }
}
```

#### To install, configure, enable and start twemproxy:

Include the `twemproxy::default` recipe:

```ruby
include_recipe 'twemproxy::default'
```

#### To install and configure but not create or start the service

Include the `twemproxy::install` and `twemproxy::configure` recipe:

```ruby
include_recipe 'twemproxy::install'
include_recipe 'twemproxy::configure'
```

## Providers

### twemproxy_install

The `twemproxy_install` provider downloads and install twemproxy from a source artifact.

It does not configure or starts it.

#### Actions

It only has a default `:run` action available.

#### Attributes

The majority of the available attributes mimic the node attributes used by the recipes above.

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Required</th>
    </tr>
    <tr>
        <td><tt>mirror</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>version</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>file_name</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>download_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>artifact_type</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
</table>

#### Example

Install `twemproxy` with the default options:

```ruby
twemproxy_install 'twemproxy'
```

Install `twemproxy` by providing the download options:

```ruby
twemproxy_install 'twemproxy' do
    mirror 'https://github.com/twitter/twemproxy/archive''
    version 'v0.4.1'
    file_name ''
    download_dir '/var/tmp'
    artifact_type 'tar.gz'
end
```

### twemproxy_configure

The `twemproxy_twemproxy` provider performs all the required system tasks and deploys the yaml configuration file.

It does not install or starts it.

#### Actions

It only has a default `:run` action available.

#### Attributes

The majority of the available attributes mimic the node attributes used by the recipes above.

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Required</th>
    </tr>
    <tr>
        <td><tt>config</tt></td>
        <td>Hash</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td><tt>update_config</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>config_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>log_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>pid_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>user</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>group</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
</table>

#### Example

Configure `twemproxy` with the default options and the provided config:

```ruby
twemproxy_configuration 'twemproxy' do
    config config_hash
end
```

### twemproxy_service

The `twemproxy_service` provider performs all the required system tasks to start and/or enable twemproxy as a service.

It deploys a sysV init script - feel free to add support for other init systems and PR your changes.

It does not install or configure it.

#### Actions

It has a default `:run` action available which is the equivalent to using the `[:enable, :restart]` actions.

Available actions:

<table>
    <tr>
        <th>Actions</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><tt>:run</tt></td>
        <td>Default action - enable and restarts the service</td>
    </tr>
    <tr>
        <td><tt>:enable</tt></td>
        <td>Enable the service</td>
    </tr>
    <tr>
        <td><tt>:start</tt></td>
        <td>Start the service</td>
    </tr>
    <tr>
        <td><tt>:restart</tt></td>
        <td>Restart the service</td>
    </tr>
</table>

#### Attributes

The majority of the available attributes mimic the node attributes used by the recipes above.

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Required</th>
    </tr>
    <tr>
        <td><tt>config_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>log_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>pid_dir</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
    <tr>
        <td><tt>user</tt></td>
        <td>String</td>
        <td>No</td>
    </tr>
</table>

#### Example

Enable and restart `twemproxy` service with the default options:

```ruby
twemproxy_service 'twemproxy'
```

Enable and restart `twemproxy` service with custom options:

```ruby
twemproxy_service 'twemproxy' do
    config_dir '/etc/nutcracker'
    log_dir '/var/log/nutcracker'
    pid_dir '/var/run/nutcracker'
    user 'nutcracker'
end
```

## Development / Contributing

### Dependencies

 * [Ruby](https://www.ruby-lang.org)
 * [Bundler](http://bundler.io)

### Installation

```bash
$ git clone git@github.com:Mindera/twemproxy-cookbook.git
$ cd twemproxy-cookbook
$ bundle install
```

### Tests

To run unit tests (chefspec):
```bash
$ bundle exec rake unit
```

To run lint tests (rubocop, foodcritic):
```bash
$ bundle exec rake lint
```

To run integration tests (kitchen-ci, serverspec):
```bash
$ bundle exec rake integration
```
