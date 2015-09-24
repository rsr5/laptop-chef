
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

user 'robin' do
  uid 1000
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
