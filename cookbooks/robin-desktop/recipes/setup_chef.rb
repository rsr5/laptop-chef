
package 'chefdk' do
  source "#{Chef::Config['file_cache_path']}/chefdk.rpm"
  action :nothing
end

remote_file "#{Chef::Config['file_cache_path']}/chefdk.rpm" do
  source 'https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/'\
         'chefdk-0.7.0-1.el7.x86_64.rpm'
  mode '0644'
  action :create
  notifies :install, 'package[chefdk]', :immediately
end
