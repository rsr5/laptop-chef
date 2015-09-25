
file '/etc/rpm/macros.image-language-conf' do
  content <<-EOH
%_install_langs C:en:en_US:en_US.UTF-8
EOH
end

bash 'set gb keyboard layout' do
  code <<-EOH
    localectl set-keymap gb;
    localectl set-x11-keymap gb;
    timedatectl set-timezone Europe/London;
  EOH
end
