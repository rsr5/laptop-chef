
package 'vim'

plugins = {
  'vim-python-pep8-indent' => 'https://github.com/hynek/vim-python-pep8-indent.git',
  'python-mode' => 'https://github.com/klen/python-mode.git',
  'vim-sensible' => 'git://github.com/tpope/vim-sensible.git',
  'vim-airline' => 'https://github.com/bling/vim-airline.git',
  'tmuxline' => 'https://github.com/edkolev/tmuxline.vim',
  'vim-colors-solarized' => 'git://github.com/altercation/vim-colors-solarized.git'
}

plugins.each do |plugin, url|
  git "/home/robin/.vim/bundle/#{plugin}" do
    repository url
    revision 'master'
    action :sync
  end
end
