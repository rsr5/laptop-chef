
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
    'rxvt-unicode-256color-ml',
    'slock'
  ]
end

service 'lightdm' do
  action [:start, :enable]
end

file '/etc/X11/Xmodmap' do
  content <<-MOD
! Map Caps-Lock to be left control.

remove Lock = Caps_Lock
remove Control = Control_L
keysym Caps_Lock = Control_L
add Lock = Caps_Lock
add Control = Control_L
  MOD
end
