
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
