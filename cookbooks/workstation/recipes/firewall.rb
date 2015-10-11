
firewall 'default'

firewall_rule 'ssh' do
  port 22
  command :allow
end

# NFS Server for LibVirt/KVM Vagrant
ports = {
  'nfs' => [[2049, :udp], [2049, :tcp]],
  'lockd' => [[53_976, :udp], [42_763, :tcp]],
  'mountd' => [[20_048, :udp], [20_048, :tcp]],
  'rpcbind' => [[111, :tcp], [111, :udp]]
}

ports.each do |service, port_protocols|
  port_protocols.each do |port, protocol|
    firewall_rule service do
      port port
      protocol protocol
      command :allow
      action :create
    end
  end
end
