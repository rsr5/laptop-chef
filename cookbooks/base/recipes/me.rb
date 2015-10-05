
require 'etc'

node.default['authorization']['sudo']['include_sudoers_d'] = true

include_recipe 'sudo::default'

package 'shell \'n\' stuff' do
  package_name %w(
    zsh
    git
    tmux
    vim
    gnupg
  )
end

# Find the lowest free UID for Robin
uid = 1000
for x in 1..10 do
  begin
    passwd = ETC.gtpwuid(uid + x)
    uid = uid + x
    break
  rescue
    # do nothing
  end
end

user 'robin' do
  uid uid
  password '$6$5UDpp4lP$MHXcLanvZ44b9atZuHmd0rPmlMdJlMOjl1MbiZ1qydrw'\
           '6APpwCGss9wKjr546LonD43lmgKMxb7Fd7tQlRmWy/'
  shell '/usr/bin/zsh'
end

group 'docker' do
  action :modify
  members 'robin'
  append true
end

sudo 'robin' do
  user 'robin'
end

bash 'configure git' do
  user 'robin'
  environment 'HOME' => '/home/robin'
  code <<-GIT
  git config --global user.email "robin.ridler@gmail.com"
  git config --global user.name "Robin Ridler"
  GIT
  not_if 'git config --global --get user.email | grep "robin.ridler@gmail.com" && '\
         'git config --global --get user.name | grep "Robin Ridler"'
end

git '/home/robin/.oh-my-zsh' do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  revision 'master'
  action :sync
end

git '/home/robin/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting' do
  repository 'git://github.com/zsh-users/zsh-syntax-highlighting.git'
  revision 'master'
  action :sync
end

git '/var/dotfiles' do
  repository 'https://github.com/rsr5/dotfiles.git'
  revision 'master'
  action :sync
end

execute 'sync dotfiles' do
  user 'robin'
  command 'rsync -rlptD --exclude \'.git\' /var/dotfiles/ /home/robin/'
end
