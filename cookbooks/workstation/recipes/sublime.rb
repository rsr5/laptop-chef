
package 'ShellCheck'

python_package 'flake8'
python_package 'codeintel' do
  action :upgrade
end

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
  not_if { File.exist?('/opt/sublime_text_3') }
end

link '/usr/bin/sublime_text' do
  to '/opt/sublime_text_3/sublime_text'
end

remote_file '/home/robin/.config/sublime-text-3/'\
            'Installed Packages/Package Control.sublime-package' do
  source 'https://sublime.wbond.net/Package%20Control.sublime-package'
  owner 'robin'
  group 'robin'
end
