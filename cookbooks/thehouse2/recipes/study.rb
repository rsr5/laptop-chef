
openhab_item 'Study' do
  type 'Group'
  icon 'office'
  filename 'study'
  groups %w(GroundFloor)
end

openhab_item 'StudyRGBW' do
  filename 'study'
  type 'Group'
  label 'Under Cupboard Lights'
  icon 'colorwheel'
  groups %w(Study)
end

openhab_item 'StudyRGBWAll' do
  filename 'study'
  type 'Dimmer'
  label 'RGBW Light Control [%d %%]'
  icon 'switch'
  binding 'zwave="23"'
  groups %w(Study StudyRGBW)
end

openhab_item 'StudyRGBWPicker' do
  filename 'study'
  type 'Color'
  label 'RGBW Light Color Picker'
  icon 'slider'
  groups %w(Study StudyRGBW)
end

[['Red', 2], ['Green', 3], ['Blue', 4], ['White', 5]].each do |color, zwave|
  openhab_item "StudyRGBW#{color}" do
    filename 'Study'
    type 'Dimmer'
    label "RGBW Light #{color} [%d %%]"
    icon 'switch'
    binding "zwave=\"23:#{zwave}\""
    groups %w(Study StudyRGBW)
  end
end
