
file '/etc/rpm/macros.image-language-conf' do
  content <<-EOH
%_install_langs C:en:en_US:en_US.UTF-8
EOH
end

#execute 'glibc-common' do
#  command 'dnf reinstall -y glibc-common'
#end
