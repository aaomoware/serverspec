require 'spec_helper'

logstash_version = '1.4.2'
logstash_package = 'logstash'
logstash_broker_init = '/etc/init.d/logstash-broker'
logstash_broker_conf_dir = '/etc/logstash/broker.conf.d'
logstash_broker_log_dir = '/var/log/logstash-broker'
logstash_broker_service = 'logstash-broker'


describe package("#{logstash_package}") do
	it { should be_installed }
end

describe file("#{logstash_broker_conf_dir}") do
	it { should be_directory }
end

describe file("#{logstash_broker_init}") do
	it { should be_file }
end

describe file("#{logstash_broker_log_dir}") do
	it { should be_directory}
end

describe command("ls #{logstash_broker_conf_dir}") do
	its(:stdout) { should match /0_redis_0_main.conf/ }
	its(:stdout) { should match /2_elastic_0_main.conf/ }
end

describe service("#{logstash_broker_service}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{logstash_package}") do
	its(:stdout) { should match /Version     : #{logstash_version}/}
end