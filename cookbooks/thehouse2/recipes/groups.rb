
openhab_item 'All' do
  type 'Group'
  filename 'groups'
end

openhab_item 'GroundFloor' do
  type 'Group'
  label 'Ground Floor'
  filename 'groups'
  groups %w(All)
end

openhab_item 'Lights' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

openhab_item 'GroundFloorLights' do
  type 'Group'
  label 'Ground Floor Lights'
  filename 'groups'
  groups %w(GroundFloor Lights)
end


openhab_item 'Upstairs' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

openhab_item 'Sensors' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

openhab_item 'Presence' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

openhab_item 'Computers' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end

#TODO: This should be a Group:Switch
openhab_item 'PresenceAnyone' do
  type 'Group'
  filename 'groups'
  groups %w(All)
end
