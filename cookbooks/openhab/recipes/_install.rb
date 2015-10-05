
package 'unzip'

user 'openhab'

directory '/opt/openhab' do
  owner 'openhab'
end

directory '/opt/openhab/addons_cache' do
  owner 'openhab'
end

execute 'unpack openhab' do
  cwd '/opt/openhab'
  user 'openhab'
  command "unzip #{Chef::Config[:file_cache_path]}/openhab.zip"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/openhab.zip" do
  source 'https://bintray.com/artifact/download/openhab/bin/'\
         'distribution-1.7.1-runtime.zip'
  notifies :run, 'execute[unpack openhab]', :immediately
end

execute 'unpack addons' do
  cwd '/opt/openhab/addons_cache'
  user 'openhab'
  command "unzip #{Chef::Config[:file_cache_path]}/addons.zip"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/addons.zip" do
  source 'https://bintray.com/artifact/download/openhab/bin/'\
         'distribution-1.7.1-addons.zip'
  notifies :run, 'execute[unpack addons]', :immediately
end
