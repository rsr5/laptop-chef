
package 'vim'
package 'the_silver_searcher'

plugins = {
  'vim-python-pep8-indent' => 'https://github.com/hynek/vim-python-pep8-indent.git',
  'python-mode' => 'https://github.com/klen/python-mode.git',
  'vim-sensible' => 'git://github.com/tpope/vim-sensible.git',
  'vim-airline' => 'https://github.com/bling/vim-airline.git',
  'tmuxline' => 'https://github.com/edkolev/tmuxline.vim',
  'vim-colors-solarized' => 'git://github.com/altercation/vim-colors-solarized.git',
  'syntastic' => 'https://github.com/scrooloose/syntastic.git',
  'ctrlp' => 'https://github.com/kien/ctrlp.vim.git',
  'gitgutter' => 'git://github.com/airblade/vim-gitgutter.git',
  'minibufferexplorer' => 'https://github.com/fholgado/minibufexpl.vim.git',
  'surround' => 'https://github.com/tpope/vim-surround'
}

plugins.each do |plugin, url|
  git "/home/robin/.vim/bundle/#{plugin}" do
    repository url
    revision 'master'
    action :sync
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
