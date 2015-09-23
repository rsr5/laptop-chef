# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'robins/fedora22'
  config.ssh.password = 'vagrant'
  config.vm.provider 'virtualbox' do |v|
    v.gui = true
    v.cpus = 2
  end

  config.vm.provision 'file',
                      source: '/etc/my_secret_key',
                      destination: '/var/tmp/passphrase'

  config.vm.provision 'chef_zero' do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'robin-desktop'
  end
end
