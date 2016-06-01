require 'spec_helper'

grafana_user = 'grafana'
grafana_group = "#{grafana_user}"
grafana_service = "#{grafana_user}-server"
grafana_home = "/usr/share/grafana"
grafana_ini_path = "/etc/#{grafana_user}/#{grafana_user}.ini"
grafana_data_path = "/var/lib/#{grafana_user}"
grafana_logs_path = "/var/log/#{grafana_user}"
grafana_conf_template = 'grafana.ini'
grafana_package = "#{grafana_user}"
grafana_version = '2.1.0'

describe package("#{grafana_package}") do
	it {should be_installed }
end

describe user("#{grafana_user}") do
	it { should exist }
	it { should have_home_directory "#{grafana_home}" }
end

describe file("#{grafana_data_path}") do
	it { should be_directory }
	it { should be_owned_by "#{grafana_user}" }
end

describe file("#{grafana_logs_path}") do
	it { should be_directory }
	it { should be_owned_by "#{grafana_user}" }
end

describe command("ls #{grafana_data_path}") do
	its(:stdout) { should match /grafana.db/ }
end

describe service("#{grafana_service}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{grafana_package}") do
	its(:stdout) { should match /Version     : #{grafana_version}/}
end
