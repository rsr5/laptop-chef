
package 'systools' do
  package_name %w(
    htop
    strace
    ltrace
    jq
  )
end

link '/usr/bin/jq' do
  to '/usr/bin/jjq'
end

bash 'install compilers' do
  code <<-EOH
    sudo dnf -y groupinstall 'C Development Tools and Libraries'
    EOH
  not_if 'rpm -qa | grep gcc-c++'
end
