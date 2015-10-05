
openhab_item 'Bedroom' do
  filename 'bedroom'
  label 'Main Bedroom'
  icon 'bedroom'
  type 'Group'
  groups %w(Upstairs)
end

openhab_item 'Bedroom_Main_Light' do
  filename 'bedroom'
  label 'Ceiling Light [%d %%]'
  groups %w(Bedroom)
  binding 'zwave="9"'
end
