
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

execute 'rebuild fontcache' do
  user 'robin'
  command 'fc-cache -vf /home/robin/.fonts/'
  action :nothing
  environment 'HOME' => '/home/robin'
end

execute 'setup powerline fonts' do
  user 'robin'
  command "#{Chef::Config['file_cache_path']}/powerline/install.sh"
  action :nothing
  environment 'HOME' => '/home/robin'
  notifies :run, 'execute[rebuild fontcache]', :immediately
end

git "#{Chef::Config['file_cache_path']}/powerline/" do
  repository 'https://github.com/powerline/fonts.git'
  revision '4151af0d071503fa7f728dc7779370059258a0e9'
  action :sync
  notifies :run, 'execute[setup powerline fonts]', :immediately
end
