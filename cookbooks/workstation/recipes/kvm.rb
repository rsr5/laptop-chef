
include_recipe 'vagrant::fedora'

bash 'group install kvm' do
  code <<-EOH
    sudo yum groupinstall -y @virtualization
    EOH
end

package 'vagrant libvirt deps' do
  package_name %w(
    libxslt-devel
    libxml2-devel
    libvirt-devel
    libguestfs-tools-c
    nfs-utils
    system-config-nfs
    qemu-img
    ruby-libvirt
    ruby-devel
  )
end

service 'libvirtd' do
  action [:enable, :start]
end

service 'nfs-server' do
  action [:enable, :start]
end

vagrant_plugin 'vagrant-libvirt' do
  user 'robin'
end

group 'kvm' do
  action :modify
  members 'robin'
 append true
end

group 'libvirt' do
  action :modify
  members 'robin'
 append true
end
