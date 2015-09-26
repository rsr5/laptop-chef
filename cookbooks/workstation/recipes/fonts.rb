
package 'font deps' do
  package_name %w(
    rpm-build
    wget
    ttmkfdir
    cabextract
  )
end

cookbook_file '/tmp/mstt-fonts.spec' do
  source 'mstt-fonts.spec'
end

bash 'create font package and install' do
  code <<-EOH
    cd /tmp
    rpmbuild -bb /tmp/mstt-fonts.spec
    rpm -i /root/rpmbuild/RPMS/noarch/msttcorefonts-2.5-1.noarch.rpm
    EOH
  not_if "rpm -qa msttcorefonts | grep msttcorefonts"
end
