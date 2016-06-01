require 'spec_helper'

stunnel_package = 'stunnel'
stunnel_version = '4.29'
stunnel_key_name = 'monitoring'
stunnel_key_type = ['crt', 'key']
stunnel_cert_dir = '/etc/stunnel/x509'
stunnel_listening_ports = ['5672','4567']
file_array = ['/etc/stunnel/stunnel.conf', '/etc/init.d/stunnel']

describe package("#{stunnel_package}") do 
	it { should be_installed }
end

file_array.each { |file|
	describe file("#{file}") do
		it { should be_file }
	end
}

describe file("#{stunnel_cert_dir}") do
	it { should be_directory }
end

stunnel_key_type.each { |type|
	describe file("#{stunnel_cert_dir}/#{stunnel_key_name}.#{type}") do
		it { should be_file }
	end
}

describe service("#{stunnel_package}") do
	it { should be_enabled }
	it { should be_running }
end

describe command("yum info #{stunnel_package}") do
	its(:stdout) { should match /Version     : #{stunnel_version}/}
end