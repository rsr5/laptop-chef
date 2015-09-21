
bash 'group install workstation' do
  code <<-EOH
    sudo dnf groupinstall -y "Fedora Workstation"
    EOH
end

package 'windowing' do
  package_name [
    'lightdm',
    'xmonad',
    'xmobar',
    'rxvt-unicode-256color'
  ]
end

service 'lightdm' do
  action :start
end
