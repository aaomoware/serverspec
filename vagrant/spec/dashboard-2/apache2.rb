require 'spec_helper'

apache_user = 'apache'
apache_service = 'httpd'
apache_dir = '/etc/httpd'
apache_template = 'reverse-proxy.conf'
apache_public_dir = '/var/www'
apache_conf_dir = "{{ apache_dir }}/conf.d"

describe package("#{apache_service}") do
	it { should be_installed }
end

describe file("#{apache_conf_dir}") do
	it { should be_file }
end

describe command("cat #{apache_conf_dir}/#{apache_template}") do
	its(:stdout) { should match /uchiwa/ }
	its(:stdout) { should match /kibana/ }
	its(:stdout) { should match /grafana/ }
	its(:stdout) { should match /localhost:3000/ }
	its(:stdout) { should match /127.0.0.1:5601/ }
	its(:stdout) { should match /localhost:5602/ }
end

describe service("#{apache_service}") do
	it { should be_enabled }
	it { should be_running }
end
