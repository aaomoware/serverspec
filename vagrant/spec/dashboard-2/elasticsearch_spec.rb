require 'spec_helper'

es_pkg_name = 'elasticsearch'
es_pkg_version = '1.5.0'
es_cluster_name = 'elasticsearch'
es_template = 'elasticsearch.yml'
es_conf_dir = '/etc/elasticsearch'

describe package("#{es_pkg_name}") do 
	it { should be_installed }
end

describe service("#{es_pkg_name}") do
	it { should be_enabled }
	it { should be_running }
end

describe file("#{es_conf_dir}/#{es_template}") do
	it { should be_file }
end

describe command("cat #{es_conf_dir}/#{es_template}") do
	its(:stdout) { should match /log_search/ }
	its(:stdout) { should match /dashboard-2/ }
end

describe command("yum info #{es_pkg_name}") do
	its(:stdout) { should match /Version     : #{es_pkg_version}/}
end
