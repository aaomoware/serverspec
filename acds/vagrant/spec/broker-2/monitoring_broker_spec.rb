require 'spec_helper'

rabbitmq_service = 'rabbitmq-server'
rabbitmq_version = "3.4.4"
haproxy_version = '1.5.2'
erlang_version= 'R14B'
rabbitmq_module_dependency = 'python.x86_64'
rabbitmq_home_directory = '/var/lib/rabbitmq'
rabbitmq_clustered = '/etc/rabbitmq/clustered'
rabbitmq_command = ['rabbitmqctl list_vhosts', 'rabbitmqctl list_users']
erlang_packages = ['erlang-appmon','erlang-asn1','erlang-common_test','erlang-compiler','erlang-cosEventDomain','erlang-cosEvent','erlang-cosFileTransfer','erlang-cosNotification','erlang-cosProperty','erlang-cosTime','erlang-cosTransactions','erlang-crypto','erlang-debugger','erlang-dialyzer','erlang-diameter','erlang-docbuilder','erlang-edoc','erlang-erl_docgen','erlang-erl_interface','erlang-erts','erlang-et','erlang-eunit','erlang-examples','erlang-gs','erlang-hipe','erlang-ic','erlang-inets','erlang-inviso','erlang-jinterface','erlang-kernel','erlang-megaco','erlang-mnesia','erlang-observer','erlang-odbc','erlang-orber','erlang-os_mon','erlang-otp_mibs','erlang-parsetools','erlang-percept','erlang-pman','erlang-public_key','erlang','erlang-reltool','erlang-runtime_tools','erlang-sasl','erlang-snmp','erlang-ssh','erlang-ssl','erlang-stdlib','erlang-syntax_tools','erlang-test_server','erlang-toolbar','erlang-tools','erlang-tv','erlang-typer','erlang-webtool','erlang-wx','erlang-xmerl']

describe package("#{rabbitmq_service}") do
	it {should be_installed }
end

describe package("#{rabbitmq_module_dependency}") do 
	it { should be_installed }
end

describe file("#{rabbitmq_home_directory}") do
	it { should be_directory }
end

describe file("#{rabbitmq_clustered}") do
	it { should be_file }
end

describe service("#{rabbitmq_service}") do
	it { should be_enabled }
	it { should be_running }
end

rabbitmq_command.each { |cmd|
	describe command("#{cmd}") do
		its(:stdout) { should match /sensu/ }
	end
}

describe command("yum info #{rabbitmq_service}") do
	its(:stdout) { should match /Version     : #{rabbitmq_version}/}
end

erlang_packages.each { |cmd|
	describe command("yum info #{cmd}") do
		its(:stdout) { should match /Version     : #{erlang_version}/}
	end
}

describe command("yum info haproxy") do
	its(:stdout) { should match /Version     : #{haproxy_version}/}
end
