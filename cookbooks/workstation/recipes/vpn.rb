
package 'vpnc'
package 'iptraf'

file '/usr/local/bin/vpn' do
  content <<-MOD
#!/bin/bash

sudo vpnc
sudo vpnc --local-port 0 staging.conf
sudo vpnc --local-port 0 prod.conf
  MOD
  mode '0755'
end
