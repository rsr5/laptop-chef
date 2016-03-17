source 'https://supermarket.chef.io'

if ENV['USE_LOCAL']
  cookbook 'base', path: '/home/robin/code/cookbook-base'
  cookbook 'workstation', path: '/home/robin/code/cookbook-workstation'
else
  cookbook 'base', git: 'git@github.com:rsr5/cookbook-base.git'
  cookbook 'workstation', git: 'git@github.com:rsr5/cookbook-workstation.git'
end
