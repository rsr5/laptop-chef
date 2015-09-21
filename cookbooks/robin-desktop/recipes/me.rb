
package 'zsh'
package 'git'
package 'tmux'
package 'vim'

user 'robin' do
  uid 1000
  password '$6$5UDpp4lP$MHXcLanvZ44b9atZuHmd0rPmlMdJlMOjl1MbiZ1qydrw'\
           '6APpwCGss9wKjr546LonD43lmgKMxb7Fd7tQlRmWy/'
  shell '/usr/bin/zsh'
end

cookbook_file '/home/robin/.Xresources' do
  source 'dotfiles/.Xresources'
  owner 'robin'
  group 'robin'
  mode '0644'
end

git '/home/robin/.oh-my-zsh' do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  revision 'master'
  action :sync
end

cookbook_file '/home/robin/.zshrc' do
  source 'dotfiles/.zshrc'
  owner 'robin'
  group 'robin'
  mode '0644'
end

directory '/home/robin/.xmonad/' do
  owner 'robin'
  group 'robin'
end

cookbook_file '/home/robin/.xmonad/xmonad.hs' do
  source 'dotfiles/xmonad.hs'
  owner 'robin'
  group 'robin'
  mode '0644'
end
