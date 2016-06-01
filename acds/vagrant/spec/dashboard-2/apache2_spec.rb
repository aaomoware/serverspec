require 'spec_helper'

apache_user = 'apache'
apache_service = 'httpd'
apache_version = '2.2.15'
apache_dir = '/etc/httpd'
apache_template = 'reverse-proxy.conf'
apache_public_dir = '/var/www'
apache_conf_dir = "#{apache_dir}/conf.d"

describe package("#{apache_service}") do
	it { should be_installed }
end

describe file("#{apache_conf_dir}/#{apache_template}") do
	it { should be_file }
end

describe command("cat #{apache_conf_dir}/#{apache_template}") do
	its(:stdout) { should match /uchiwa/ }
	its(:stdout) { should match /kibana/ }
	its(:stdout) { should match /grafana/ }
	its(:stdout) { should match /13000/ }
	its(:stdout) { should match /localhost:5601/ }
	its(:stdout) { should match /localhost:3100/ }
end

describe service("#{apache_service}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{apache_service}") do
	its(:stdout) { should match /Version     : #{apache_version}/}
end
