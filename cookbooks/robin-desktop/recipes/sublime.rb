
remote_file "#{Chef::Config['file_cache_path']}/sublime.tar.bz2" do
  source 'http://c758482.r82.cf2.rackcdn.com/'\
         'sublime_text_3_build_3083_x64.tar.bz2'
  mode '0644'
  action :create
end

execute 'install sublime' do
  user 'root'
  cwd '/opt'
  command "tar -xvjf #{Chef::Config['file_cache_path']}/sublime.tar.bz2"
end

remote_directory '/home/robin/.config/sublime-text3' do
  source 'sublime-text3'
  owner 'robin'
  group 'robin'
  mode '0755'
  action :create
end
