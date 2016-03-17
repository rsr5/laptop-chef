
multipackage %w(vim
                the_silver_searcher
                redhat-rpm-config
                ShellCheck
                git)

python_package 'flake8'

plugins = {
  'vim-python-pep8-indent' => 'hynek/vim-python-pep8-indent',
  'python-mode' => 'klen/python-mode',
  'vim-sensible' => 'tpope/vim-sensible',
  'vim-airline' => 'bling/vim-airline',
  'tmuxline' => 'edkolev/tmuxline.vim',
  'vim-colors-solarized' => 'altercation/vim-colors-solarized',
  'syntastic' => 'scrooloose/syntastic',
  'ctrlp' => 'kien/ctrlp.vim',
  'gitgutter' => 'airblade/vim-gitgutter',
  'minibufferexplorer' => 'fholgado/minibufexpl.vim',
  'nerdtree' => 'scrooloose/nerdtree',
  'nerdtree-git' => 'Xuyuanp/nerdtree-git-plugin',
  'surround' => 'tpope/vim-surround'
}

plugins['YouCompleteMe'] = 'Valloric/YouCompleteMe' if node['os'] == 'linux'

plugins.each do |plugin, url|
  git home('robin', ".vim/bundle/#{plugin}") do
    repository "https://github.com/#{url}.git"
    revision 'master'
    action :sync
    user 'robin'
  end
end

# Workaround to ignore rubocop version warnings
file '/usr/bin/chefrubocop' do
  mode 0755
  content <<-CONT
#! /bin/sh
exec chef exec rubocop "$@"
  CONT
end

if node['os'] == 'linux'
  multipackage %w(
    automake
    gcc
    gcc-c++
    kernel-devel
    cmake
  )

  bash 'install YouCompleteMe' do
    cwd '/home/robin/.vim/bundle/YouCompleteMe/'
    code <<-EOH
      git submodule update --init --recursive
      ./install.py --clang-compiler
    EOH
  end
end
