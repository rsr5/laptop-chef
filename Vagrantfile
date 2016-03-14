# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define 'workstation' do |workstation|
    workstation.vm.box = 'fedora23vbox'
    workstation.ssh.password = 'vagrant'
    workstation.vm.provider 'virtualbox' do |v|
      v.gui = true
      v.cpus = 3
      v.memory = 8192
    end

    workstation.vm.provision 'file',
                             source: '/etc/my_secret_key',
                             destination: '/var/tmp/passphrase'

    workstation.vm.provision 'shell', inline: 'sudo dnf -y install python yum'

    workstation.vm.provision 'chef_zero' do |chef|
      chef.json = {
        enable_vagrant: true
      }
      chef.add_recipe 'base::vagrant'
      chef.add_recipe 'workstation::default'
    end
  end

  config.vm.define 'server' do |server|
    server.vm.box = 'solaris11.3'
    server.vm.provision 'shell', inline: <<-SHELL
    if [[ ! -d "/opt/chef" ]]
    then
      wget 'https://opscode-omnibus-packages.s3.amazonaws.com/solaris2/5.11/i386/chef-12.8.1-1.i386.solaris' -nv
      yes | sudo pkgadd -d chef-12.8.1-1.i386.solaris all > /dev/null
    fi
    SHELL

    server.vm.provision 'chef_zero' do |chef|
      chef.add_recipe 'base::default'
    end
  end
end
