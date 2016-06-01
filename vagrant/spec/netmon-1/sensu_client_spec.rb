require 'spec_helper'

sensu_client_service = 'sensu-client'
sensu_client_conf_dir = '/etc/sensu/client.conf.d'
sensu_client_jsons = ['client.json', 'rabbit-mq-server.json', 'redis.json']

describe package("sensu") do
	it { should be_installed }
end

sensu_client_jsons.each { |file|
	describe file("#{sensu_client_conf_dir}/#{file}") do
		it { should be_file }
	end
}

describe service("#{sensu_client_service}") do
	it { should be_enabled }
	it { should be_running }
end

