require 'spec_helper'

dashboard_user = 'apache'
dashboard_apache_conf = '/etc/httpd/conf.d'
dashboard_doc_root = '/opt/deploy/reverseproxy/docroot'

describe file("#{dashboard_doc_root}") do
	it { should be_directory }
	it { should be_owned_by "#{dashboard_user}" }
end

describe file("#{dashboard_apache_conf}/00_nvh.conf") do
	it { should be_file }
end
