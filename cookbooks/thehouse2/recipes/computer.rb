
openhab_item 'Computers' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

openhab_item 'FileServerLastChange' do
  filename 'computers'
  type 'DateTime'
  label '[%1$tA, %1$td.%1$tm.%1$tY %1$tT]'
  groups %w(Computers)
end

openhab_item 'FileServer' do
  filename 'computers'
  type 'Switch'
  label 'NAS'
  groups %w(Computers)
end

openhab_item 'FileServerUp' do
  filename 'computers'
  type 'Switch'
  label 'Status [MAP(server.map):%s]'
  binding 'nh="192.168.1.2"'
  icon 'fileserver'
  groups %w(Computers)
end

openhab_item 'FileServerShutdown' do
  filename 'computers'
  type 'Switch'
  label 'Shutdown'
  binding 'exec=">[*:ssh robin@192.168.1.2 pfexec shutdown -y -g0 -i0]"'
  groups %w(Computers)
end

openhab_item 'FileServerPower' do
  filename 'computers'
  type 'Switch'
  label 'AC'
  binding 'zwave="5"'
  groups %w(Computers)
end
