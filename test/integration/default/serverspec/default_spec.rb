require 'serverspec'

# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:$PATH'
  end
end

describe user('nutcracker') do
  it { should exist }
end

describe user('nutcracker') do
  it { should belong_to_group 'nutcracker' }
end

%w{
  /etc/nutcracker
  /var/log/nutcracker
  /var/run/nutcracker
}.each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end

describe file('/etc/nutcracker/nutcracker.yml') do
  it { should be_file }
  it { should contain '127.0.0.1:6379:1' }
end

describe file('/etc/init.d/nutcracker') do
  it { should be_file }
  it { should contain 'user=nutcracker' }
end

describe command('/usr/local/sbin/nutcracker --version') do
  its(:exit_status) { should eq 0 }
end

describe command('/usr/local/sbin/nutcracker --test-conf -c /etc/nutcracker/nutcracker.yml') do
  its(:exit_status) { should eq 0 }
end

describe service('nutcracker') do
  it { should be_enabled }
end

describe service('nutcracker') do
  it { should be_running }
end
