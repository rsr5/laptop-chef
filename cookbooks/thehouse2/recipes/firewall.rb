
firewall 'default'

firewall_rule 'ssh' do
  port 22
  command :allow
end
