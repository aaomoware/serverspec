require 'spec_helper'

sensu_sys_dir = '/etc/sensu'
sensu_package = "sensu"
sensu_version = '0.17.0'
sensu_services = ['sensu-api', 'sensu-server']
sensu_server_paths = ['sensu-server', 'sensu-api', 'sensu-client']
sensu_server_conf_dir = "#{sensu_sys_dir}/server.conf.d"
sensu_server_options = ['16379','redis']
sense_server_configs = ['api.json', 'properties.json', 'rabbit-mq-server.json', 'redis.json']

describe package("#{sensu_package}") do 
	it { should be_installed }
end

sensu_server_paths.each { |file|
	describe file("/etc/sysconfig/#{file}") do
		it { should be_file }
	end
}

sensu_server_paths.each { |file|
	describe command("cat /etc/sysconfig/#{file}") do
		its(:stdout) { should match /config.json/ }
		its(:stdout) { should match /extensions/ }
		its(:stdout) { should match /plugins/ }
		its(:stdout) { should match /handlers/ }
	end
}

sense_server_configs.each { |file|
	describe file("#{sensu_server_conf_dir}/#{file}") do
		it { should be_file }
	end
}

sensu_services.each { |service| 
	describe service("#{service}") do
		it { should be_enabled }
		it { should be_running }
	end
}

describe command("yum info #{sensu_package}") do
	its(:stdout) { should match /Version     : #{sensu_version}/}
end
