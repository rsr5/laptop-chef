# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'robins/fedora22'
  config.ssh.password = 'vagrant'

  config.vm.define "workstation" do |workstation|
    workstation.vm.provider 'virtualbox' do |v|
      v.gui = true
      v.cpus = 3
      v.memory = 8192
      v.customize ['modifyvm',
                   :id,
                   '--audio',
                   'pulse',
                   '--audiocontroller',
                   'hda'] # choices: hda sb16 ac97
    end

    workstation.vm.provision 'file',
                             source: '/etc/my_secret_key',
                             destination: '/var/tmp/passphrase'

    workstation.vm.provision 'chef_zero' do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base::vagrant'
      chef.add_recipe 'base::default'
      chef.add_recipe 'workstation::default'
    end
  end

  config.vm.define "thehouse2" do |thehouse2|
    workstation.vm.provision 'chef_zero' do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base::vagrant'
      chef.add_recipe 'base::default'
      chef.add_recipe 'openhab::default'
    end
  end
end
