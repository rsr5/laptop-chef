# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'robins/fedora22'
  config.vm.provider 'virtualbox' do |v|
    v.gui = true
  end

  config.vm.provision 'chef_zero' do |chef|

    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'robin-desktop'

  end

end
