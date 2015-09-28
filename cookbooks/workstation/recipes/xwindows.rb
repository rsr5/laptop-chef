
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

service 'gdm' do
  action :disable
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

file '/usr/share/xsessions/xmonad-robin.desktop' do
  content <<-MOD
[Desktop Entry]
Name=xmonad-keyring
Comment=Tiling window manager
Exec=/usr/bin/xmonad.start
Terminal=false

[Window Manager]
SessionManaged=true

# vi: encoding=utf-8
  MOD
end

file '/usr/bin/xmonad.start' do
  content <<-MOD
#!/bin/bash

eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID

xrandr --output eDP1 --off
xrandr --output HDMI1 --auto
xrandr --output DP1 --auto
xrandr --output DP1 --left-of HDMI1

exec xmonad

  MOD
  mode '0755'
end
