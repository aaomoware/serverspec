require 'spec_helper'

kibana_user = 'kibana'
kibana_conf = 'kibana.yml'
kibana_apache_dir = "/var/www/#{kibana_user}"
kibana_home = "/opt/#{kibana_user}"

kibana_init_script = "/etc/init.d/#{kibana_user}"
kibana_current_path = "#{kibana_home}/current"
kibana_public_dir = "#{kibana_current_path}/src/public"
kibana_log_path = '/var/log/kibana.log'
kibana_host = 'localhost'


describe file("#{kibana_home}") do
	it { should be_directory }
	it { should be_owned_by "#{kibana_user}" }
end

describe user("#{kibana_user}") do
	it { should exist }
	it { should have_home_directory "#{kibana_home}" }
end

describe command("ls #{kibana_home}") do
	its(:stdout) { should match /builds/ }
	its(:stdout) { should match /current/ }
end

describe file("#{kibana_home}/current/config/kibana.yml") do
	it { should be_file }
	it { should be_owned_by "#{kibana_user}" }
end

describe file("#{kibana_init_script}") do
	it { should be_file }
	it { should be_executable }
	it { should be_owned_by 'root' }
end

describe file("#{kibana_apache_dir}") do
	it { should be_directory }
	it { should be_owned_by 'apache' }
end

describe command("ls #{kibana_apache_dir}") do
	its(:stdout) { should match /apps/ }
	its(:stdout) { should match /build.txt/ }
	its(:stdout) { should match /index.html/ }
	its(:stdout) { should match /require.config.js/ }
end

describe service("#{kibana_user}") do
	it { should be_enabled }
	it { should be_running }
end

