require 'spec_helper'

logstash_pkg = 'logstash'
logstash_service = 'logstash'
logstash_version = '1.4.2'
logstash_conf_dir = '/etc/logstash/conf.d'
logstash_user = 'logstash'
logstash_redis_type = 'list'
logstash_redis_key = 'logstash'
logstash_home_dir = "/opt/#{logstash_pkg}"
file_array = ['0_basic_files.conf', '2_redis.conf']


describe package("#{logstash_pkg}") do
	it { should be_installed }
end

describe user("#{logstash_user}") do
	it { should exist }
	it { should have_home_directory "#{logstash_home_dir}" }
	it { should have_login_shell "/sbin/nologin" }
end

file_array.each { |file|
	describe file("#{logstash_conf_dir}/#{file}") do
		it { should be_file }
	end
}

describe command("cat #{logstash_conf_dir}/2_redis.conf") do
	 its(:stdout) { should match /#{logstash_redis_type}/ }
	 its(:stdout) { should match /#{logstash_redis_key}/ }
end

describe service("#{logstash_service}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{logstash_pkg}") do
	its(:stdout) { should match /Version     : #{logstash_version}/}
end