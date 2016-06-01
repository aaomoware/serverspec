require 'spec_helper'
influx_package = 'influxdb'
influx_version = '0.8.8'
influx_conf_file = '/opt/influxdb/shared/config.toml'
influx_conf_options = ['write-buffer-size = 10000','reporting-disabled = false','read-timeout = "5s"']

describe package("#{influx_package}") do
	it { should be_installed }
end

describe file("#{influx_conf_file}") do
	it { should be_file }
end

describe service("#{influx_package}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{influx_package}") do
	its(:stdout) { should match /Version     : #{influx_version}/}
end

influx_conf_options.each { |cmd|
	describe command("cat #{influx_conf_file}") do
		its(:stdout) { should match /#{cmd}/}
	end
}
