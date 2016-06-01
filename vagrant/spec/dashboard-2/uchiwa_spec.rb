require 'spec_helper'

uchiwa_user = 'uchiwa'
uchiwa_pkg = 'uchiwa'
uchiwa_version = '0.8.1'
uchiwa_home = "/opt/#{uchiwa_user}"
uchiwa_service = "#{uchiwa_user}"
uchiwa_conf = "/etc/sensu/#{uchiwa_user}.json"
uchiwa_config_options = ['4568','13000','apiuser']

describe package("#{uchiwa_pkg}") do
	it { should be_installed }
end

describe file("#{uchiwa_home}") do
	it { should be_directory }
	it { should be_owned_by 'root' }
end

describe file("#{uchiwa_conf}") do
	it { should be_file }
end

describe command("ls #{uchiwa_home}") do
	its(:stdout) { should match /bin/ }
	its(:stdout) { should match /src/ }
end

describe service("#{uchiwa_pkg}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{uchiwa_pkg}") do
	its(:stdout) { should match /Version     : #{uchiwa_version}/}
end

uchiwa_config_options.each { |cmd|
	describe command("cat #{uchiwa_conf}") do
		its(:stdout) { should match /#{cmd}/ }
	end
}
