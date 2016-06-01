require 'spec_helper'

cman_pacemaker = ['cman', 'pacemaker']
pacemaker_packages = ['ccs', 'pcs' ,'cman', 'pacemaker', 'resource-agents']
pacemaker_config = '/etc/cluster/cluster.conf'
pacemaker_cman_conf_file = '/etc/sysconfig/cman'
pacemaker_ocf_dir = '/usr/lib/ocf/resource.d/heartbeat'
pacemaker_disable_quorum_prerequisite = 'CMAN_QUORUM_TIMEOUT=0'

pacemaker_packages.each { |package|
	describe package("#{package}") do
		it { should be_installed }
	end
}

cman_pacemaker.each { |package|
	describe service("#{package}") do
		it { should be_enabled }
		it { should be_running }
	end
}

describe file("#{pacemaker_config}") do
	it { should be_file }
end

describe file("#{pacemaker_cman_conf_file}") do
	it { should be_file }
end

describe file("#{pacemaker_ocf_dir}") do
	it { should be_directory }
end

describe command("cat #{pacemaker_cman_conf_file}") do
	its(:stdout) { should match /#{pacemaker_disable_quorum_prerequisite}/ }
end

describe command("pcs status") do
	its(:stdout) { should match /res_VirtualIP/ }
	its(:stdout) { should match /res_Haproxy/ }
end

describe command("pcs constraint list") do
	its(:stdout) { should match /res_VirtualIP/ }
	its(:stdout) { should match /res_VirtualIP/ }
end

describe command("cat #{pacemaker_config}") do
	its(:stdout) { should match /nodeid="1"/ }
	its(:stdout) { should match /nodeid="2"/ }
end

describe command('yum info ccs') do 
	its(:stdout) { should match /Version     : 0.16.2/ }
end

#describe command('yum info pcs') do
#	its(:stdout) { should match /Version     : 0.9.139/ }
#end

describe command('yum info cman') do
	its(:stdout) { should match /Version     : 3.0.12.1/ }
end

describe command('yum info pacemaker') do
	its(:stdout) { should match /Version     : 1.1.12/ }
end

describe command('yum info resource-agents') do
	its(:stdout) { should match /Version     : 3.9.5/ }
end
