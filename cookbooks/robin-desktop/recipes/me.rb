
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
  repository 'https://github.com/rsr5/dotfiles'
  revision 'master'
  action :sync
end

execute 'sync dotfiles' do
  user 'robin'
  command 'rsync -rlptD --exclude \'.git\' /var/dotfiles/ /home/robin/'
end

execute 'fix perms' do
  command 'chown -R robin:robin /home/robin/.gnupg'
  action :nothing
end

bash 'sort out encryption' do
  user 'robin'
  cwd '/home/robin/'
  environment 'HOME' => '/home/robin'
  code <<-EOH
    cat /var/tmp/passphrase | gpg --no-tty --passphrase-fd 0 -o gnupg.tar data
    rm -rf .gnupg
    tar -xvf gnupg.tar
    rm gnupg.tar
    EOH
  not_if File.exist?('/home/robin/.gnupg')
  notifies :run, 'execute[fix perms]', :immediately
end
