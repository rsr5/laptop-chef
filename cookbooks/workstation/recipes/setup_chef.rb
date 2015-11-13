
directory '/home/robin/code' do
  owner 'robin'
  group 'robin'
end

ruby_block 'add_to_path' do
  block do
    ENV['OLD_GEM_HOME'] = ENV['GEM_HOME']
    ENV['GEM_HOME'] = '/opt/chefdk/embedded/lib/ruby/gems/2.1.0'
  end
end

%w(chef-provisioning-docker
   knife-block
   pry-byebug
   pry-theme
   pry-stack_explorer
   awesome_print).each do |gem|
  gem_package gem do
    gem_binary('/opt/chefdk/embedded/bin/gem')
    options('--no-user-install')
    action :upgrade
  end
end

file '/home/robin/.pryrc' do
  owner 'robin'
  group 'robin'
  mode 0644
  content <<-CONT
# ~/.pryrc
Pry.config.theme = 'solarized'

require 'awesome_print'
AwesomePrint.pry!
  CONT
end

directory '/home/robin/.pry' do
  owner 'robin'
  group 'robin'
  mode 0755
end

directory '/home/robin/.pry/themes' do
  owner 'robin'
  group 'robin'
  mode 0755
end

cookbook_file '/home/robin/.pry/themes/solarized.prytheme' do
  owner 'robin'
  group 'robin'
  mode 0644
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

if File.exist?('/home/robin/.chef-generator')
  git '/home/robin/.chef-generator' do
    repository 'git@github.com:datasift/chef-code-generator.git'
    revision 'master'
    action :sync
  end
end

directory '/home/robin/code/cookbooks' do
  owner 'robin'
  group 'robin'
end

cookbook_file '/home/robin/code/cookbooks/list_repos.py' do
  mode '0755'
  owner 'robin'
  group 'robin'
  source 'list_repos.py'
end

cron 'sync cookbook repos' do
  minute '0'
  hour '10'
  user 'robin'
  mailto 'robin.ridler@gmail.com'
  home '/home/robin'
  command %w(
    cd /home/robin/code/cookbooks &&
    ./list_repos.py > /home/robin/code/cookbooks/.project.gws
  ).join(' ')
end

remote_file '/usr/bin/gws' do
  source 'https://raw.githubusercontent.com/StreakyCobra/gws/'\
         '3618de83937c895ab38fba75d8cf85b237d343e2/src/gws'
  mode '0755'
end
