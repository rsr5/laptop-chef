
%w(
  binding.zwave
  persistence.mqtt
  binding.mqtt
  binding.mqttitude
  binding.rfxcom
  action.astro
  action.pushover
  binding.astro
  binding.exec
  binding.http
  binding.networkhealth
  ).each do |addon|
  openhab_addon addon
end

include_recipe 'thehouse2::groups'
include_recipe 'thehouse2::livingroom'
include_recipe 'thehouse2::bedroom'
include_recipe 'thehouse2::computer'
include_recipe 'thehouse2::kitchen'
include_recipe 'thehouse2::astro'


openhab_item 'OvertonTemp' do
  filename 'sensors'
  type 'Number'
  label "Overton Temperature [%.1f °C]"
  binding 'exec="<[cat /opt/openhab/thehouse/current_temp:60000:REGEX((.*?))]"'
  groups %w(Sensors)
end

openhab_item 'PresenceRobin' do
  filename 'sensors'
  type 'Switch'
  label "Robin Home?"
  binding 'nh="android-38353765c4f6f7c6"'
  groups %w(Presence PresenceAnyone)
end

openhab_item 'PresenceSoph' do
  filename 'sensors'
  type 'Switch'
  label "Soph Home?"
  binding 'nh="android-9117158ebf3ed090"'
  groups %w(Presence PresenceAnyone)
end



<<-ITEMS

Group:Switch:OR(ON, OFF) Lights
Group:Switch:OR(ON, OFF) GroundFloorLights
Group:Switch:OR(ON, OFF) UpstairsLights

Group:Switch:OR(ON, OFF) PresenceAnyone "Anbody home?"

# This is not used anymore?
Switch TV_AMP "TV/Amp" (LivingRoom, GroundFloorLights) { zwave="11" }
Switch  Cupboard_lights   "Kitchen cupboard lights."   (Kitchen, GroundFloorLights, Lights) { zwave="6" }

# This was the one on the landing?
Number LivingRoomTempF  "Temperature [%.1f °F]" (LivingRoom) { zwave="8:command=sensor_multilevel,sensor_type=1"}
Number LivingRoomTempC  "Living Room Temperature [%.1f °C]" (LivingRoom, Sensors) 
Number LivingRoomLight  "Light [%d %%]" (LivingRoom, Sensors) { zwave="8:command=sensor_multilevel,sensor_type=3" }
Contact LivingRoomMovement  "Movement Detected" (LivingRoom) { zwave="8:command=SENSOR_BINARY" }
DateTime LastLivingRoomMovement "Motion Detected [%1$tA, %1$td.%1$tm.%1$tY %1$tT]"

ITEMS
