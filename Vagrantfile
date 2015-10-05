# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'fedora23-beta-20150915'
  config.ssh.password = 'vagrant'
  config.omnibus.chef_version = "12.4.1"

  config.vm.provider 'libvirt' do |v|
   v.machine_virtual_size = 50
  end

  config.vm.define "workstation" do |workstation|
    workstation.vm.provider 'libvirt' do |v|
      v.cpus = 3
      v.memory = 8192
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

    thehouse2.vm.provider 'libvirt' do |v|
      v.cpus = 1
      v.memory = 2048
    end

    thehouse2.vm.provision 'chef_zero' do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe 'base::hack_dnf'
      chef.add_recipe 'base::vagrant'
      chef.add_recipe 'base::default'
      chef.add_recipe 'openhab::default'
    end
  end
end
