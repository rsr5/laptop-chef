
openhab_item 'LivingRoom' do
  filename 'livingroom'
  type 'Group'
  label 'Living Room'
  icon 'sofa'
  groups %w(GroundFloor)
end

openhab_item 'LivingRoom_BigLamp' do
  filename 'livingroom'
  type 'Dimmer'
  label 'Big Lamp'
  groups %w(LivingRoom GroundFloorLights Lights)
  binding 'zwave="7"'
end

openhab_item 'LivingRoom_StairsLamp' do
  filename 'livingroom'
  type 'Switch'
  label 'Under Stairs Lamp'
  groups %w(LivingRoom GroundFloorLights Lights)
  binding 'zwave="10"'
end
