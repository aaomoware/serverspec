require 'spec_helper'

redis_version = '2.8.19'
redis_pkd_name = 'redis'
redis_lst_port = '6379'
redis_config_options = ['timeout 0','tcp-keepalive 10','loglevel notice','port 6379','syslog-ident "redis"','databases 16']

describe package("#{redis_pkd_name}") do
	it { should be_installed }
end

describe service("#{redis_pkd_name}") do
	it { should be_running }
end

describe port("#{redis_lst_port}") do
	it { should be_listening.with('tcp') }
end

describe command("yum info #{redis_pkd_name}") do
	its(:stdout) { should match /Version     : #{redis_version}/}
end

redis_config_options.each { |cmd|
	describe command("cat /etc/redis.conf") do
		its(:stdout) { should match /#{cmd}/ }
	end
}