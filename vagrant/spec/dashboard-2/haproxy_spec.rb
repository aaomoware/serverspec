require 'spec_helper'

haproxy_package = 'haproxy'
haproxy_version = '1.5.2'
haproxy_config = '/etc/haproxy/haproxy.cfg'

describe package("#{haproxy_package}") do
	it { should be_installed }
end

describe command("cat #{haproxy_config}") do
	its(:stdout) { should match /:4568/ }
	its(:stdout) { should match /check port 4567/ }
	its(:stdout) { should match /inter 5000 downinter 2000/ }
	its(:stdout) { should match /:8080/ }
	its(:stdout) { should match /check port 8080/ }
	its(:stdout) { should match /monitor-1/ }
	its(:stdout) { should match /dashboard-2/ }
end

describe service("#{haproxy_package}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{haproxy_package}") do
	its(:stdout) { should match /Version     : #{haproxy_version}/}
end
