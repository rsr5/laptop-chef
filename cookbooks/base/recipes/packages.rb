
package 'systools' do
  package_name %w(
    htop
    strace
    ltrace
    jq
  )
end

link '/usr/bin/jq' do
  to '/usr/bin/jjq'
end

bash 'install compilers' do
  code <<-EOH
    sudo dnf -y groupinstall 'C Development Tools and Libraries'
    EOH
  not_if 'rpm -qa | grep gcc-c++'
end

package 'chefdk' do
  source "#{Chef::Config['file_cache_path']}/chefdk.rpm"
  action :nothing
end

remote_file "#{Chef::Config['file_cache_path']}/chefdk.rpm" do
  source 'https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/'\
         'chefdk-0.11.0-1.el7.x86_64.rpm'
  mode '0644'
  action :create
  notifies :upgrade, 'package[chefdk]', :immediately
end
