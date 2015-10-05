
openhab_item 'Kitchen' do
  type 'Group'
  icon 'kitchen'
  filename 'kitchen'
  groups %w(GroundFloor)
end

openhab_item 'Webcam' do
  type 'Group'
  filename 'kitchen'
  groups %w(Kitchen)
end

%w(Up Down Left Right).each do |dir|
  openhab_item "Webcam#{dir}" do
    type 'Switch'
    label dir
    filename 'kitchen'
    groups %w(Webcam)
    binding "exec=\">[ON:/opt/openhab/thehouse/camera.py #{dir.downcase}]\""
  end
end

openhab_item 'KitchenMovement' do
  type 'Contact'
  label 'Movement [%s]'
  filename 'kitchen'
  groups %w(Kitchen)
  icon 'pir'
  binding 'zwave="12:1:command=SENSOR_BINARY"'
end

openhab_item 'LastKitchenMovement' do
  type 'DateTime'
  label 'Motion Detected [%1$tA, %1$td.%1$tm.%1$tY %1$tT]'
  filename 'kitchen'
  groups %w(Kitchen)
end

openhab_item 'KitchenTempC' do
  type 'Number'
  label 'Temperature [%.2f °C]'
  filename 'kitchen'
  icon 'temperature'
  binding 'zwave="12:1:command=SENSOR_MULTILEVEL,sensor_type=1"'
  groups %w(Kitchen)
end

openhab_item 'KitchenLight' do
  type 'Number'
  label 'Light [%.0f Lux]'
  filename 'kitchen'
  icon 'temperature'
  binding 'zwave="12:1:command=SENSOR_MULTILEVEL,sensor_type=3"'
  groups %w(Kitchen)
end

openhab_item 'KitchenBattery' do
  type 'Number'
  label 'Battery [%d %%]'
  filename 'kitchen'
  icon 'temperature'
  binding 'zwave="12:1:command=battery"'
  groups %w(Kitchen)
end
