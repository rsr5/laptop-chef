
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
  )
end

service 'libvirtd' do
  action [:enable, :start]
end

vagrant_plugin 'vagrant-libvirt' do
  user 'robin'
end
