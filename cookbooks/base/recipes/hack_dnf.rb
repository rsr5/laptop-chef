
bash 'hack dnf' do
  code <<-EOH
    sudo dnf -y install yum
    sudo mv /usr/bin/yum /usr/bin/yum-dnf
    sudo ln -s /usr/bin/yum-deprecated /usr/bin/yum
    EOH
  not_if { File.exist?('/usr/bin/yum-dnf') }
end
