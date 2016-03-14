
yum_repository 'virtualbox' do
  description 'Fedora $releasever - $basearch - VirtualBox'
  baseurl 'http://download.virtualbox.org/'\
          'virtualbox/rpm/fedora/$releasever/$basearch'
  enabled true
  gpgcheck true
  repo_gpgcheck true
  gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
end

package 'VirtualBox-5.0'

execute 'setup vbox driver' do
  command '/usr/lib/virtualbox/vboxdrv.sh'
  action :nothing
end

multipackage 'vbox dependencies' do
  package_name %w(
    binutils
    gcc
    make
    patch
    libgomp
    glibc-headers
    glibc-devel
    kernel-headers
    kernel-devel
    dkms
  )
  notifies :run, 'execute[setup vbox driver]', :immediately
end
