require 'spec_helper'
haproxy_port = '16379'
haproxy_package = 'haproxy'
haproxy_version = '1.5.2'
haproxy_hostname = 'broker-1'

describe package("#{haproxy_package}") do
	it { should be_installed }
end

describe service("#{haproxy_package}") do
	it { should be_enabled }
	it { should be_running }
end

describe port("#{haproxy_port}") do
	it { should be_listening.with('tcp') }
end

describe command("yum info #{haproxy_package}") do
	its(:stdout) { should match /Version     : #{haproxy_version}/}
end
