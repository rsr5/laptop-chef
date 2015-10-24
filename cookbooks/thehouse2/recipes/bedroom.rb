
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

#Number BedRoomTempF "[%.1f °F]" { zwave="8:command=sensor_multilevel,sensor_type=1" }
#Number  BedRoomTempC "Bed Room Temperature [%.1f °C]" <temperature>   (TempSensors)
#Number  BedRoomLight "Bed Room Light [%d %%]" (LightSensors) { zwave="8:command=sensor_multilevel,sensor_type=3" }
#Contact BedRoomMovement  "Movement Detected" <contact> { zwave="8:command=SENSOR_BINARY" }
#Number BedRoomBattery  "Bed Room Battery [%d %%]" (Batteries) { zwave="8:command=BATTERY" }
#DateTime LastBedRoomMovement "Last Bedroom [%1$td.%1$tm.%1$tY %1$tT]"