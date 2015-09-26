
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

ruby_block 'add_to_path' do
  block do
    ENV['OLD_GEM_HOME'] = ENV['GEM_HOME']
    ENV['GEM_HOME'] = '/opt/chefdk/embedded/lib/ruby/gems/2.1.0'
  end
end

gem_package 'kitchen-docker' do
  gem_binary('/opt/chefdk/embedded/bin/gem')
  options('--no-user-install')
  action :upgrade
end

ruby_block 'remove_from_path' do
  block do
    ENV['GEM_HOME'] = ENV['OLD_GEM_HOME']
  end
end

berks_config = {
  'chef' => {
    'node_name' => 'repoadmin',
    'client_key' => '~/.chef/autochef.pem'
  },
  'ssl' => {
    'verify' => false
  }
}

directory '/home/robin/.berkshelf' do
  owner 'robin'
  group 'robin'
end

file '/home/robin/.berkshelf/config.json' do
  content JSON.pretty_generate(berks_config)
  owner 'robin'
  group 'robin'
end
