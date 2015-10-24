
cookbook_file '/usr/bin/start_thehouse2.sh' do
  mode '0755'
end

openhab_service 'default' do
  startup_script '/usr/bin/start_thehouse2.sh'
end

%w(binding.zwave
   persistence.mqtt
   persistence.rr4dj
   binding.mqtt
   binding.rfxcom
   action.astro
   action.pushover
   binding.astro
   binding.exec
   binding.http
   binding.networkhealth).each do |addon|
  openhab_addon addon
end

cookbook_file '/opt/openhab/configurations/sitemaps/thehouse2.sitemap' do
  owner 'openhab'
  group 'openhab'
end

include_recipe 'thehouse2::firewall'
include_recipe 'thehouse2::groups'
include_recipe 'thehouse2::livingroom'
include_recipe 'thehouse2::bedroom'
include_recipe 'thehouse2::computer'
include_recipe 'thehouse2::lwrf'
include_recipe 'thehouse2::kitchen'
include_recipe 'thehouse2::astro'
include_recipe 'thehouse2::study'
include_recipe 'thehouse2::temperatures'
include_recipe 'thehouse2::presence'


<<-ITEMS

Group:Switch:OR(ON, OFF) Lights
Group:Switch:OR(ON, OFF) GroundFloorLights
Group:Switch:OR(ON, OFF) UpstairsLights

Group:Switch:OR(ON, OFF) PresenceAnyone "Anbody home?"

Contact StairsMovement "Stairs Movement [%s]" <contact>   { zwave="25:1:command=SENSOR_BINARY" }
DateTime LastStairsMovement "Last Stairs [%1$td.%1$tm.%1$tY %1$tT]"
Number StairsTempC "Stairs Temperature [%.2f °C]" <temperature> (TempSensors) { zwave="25:1:command=SENSOR_MULTILEVEL,sensor_type=1" }
Number  StairsLight    "Stairs Light [%.0f Lux]" (LightSensors)   { zwave="25:1:command=SENSOR_MULTILEVEL,sensor_type=3" }
Number  StairsBatterySensor    "Stairs Sensor Battery [%d %%]"  (Batteries)  { zwave="25:1:command=BATTERY,refresh_interval=30" }

Contact BathroomMovement "Bathroom Movement [%s]" <contact>   { zwave="26:1:command=SENSOR_BINARY" }
DateTime LastBathroomMovement "Last Stairs [%1$td.%1$tm.%1$tY %1$tT]"
Number BathroomTempC "Bathroom Temperature [%.2f °C]" <temperature> (TempSensors) { zwave="26:1:command=SENSOR_MULTILEVEL,sensor_type=1" }
Number  BathroomLight    "Bathroom Light [%.0f Lux]" (LightSensors)   { zwave="26:1:command=SENSOR_MULTILEVEL,sensor_type=3" }
Number  BathroomBatterySensor    "Bathroom Sensor Battery [%d %%]"  (Batteries)  { zwave="26:1:command=BATTERY,refresh_interval=30" }

Number Thermostat "Wanted [%d °C]" <temperature> (TempSensors) {zwave="20:command=THERMOSTAT_SETPOINT"}
Number Thermostat_Temp "Currently [%.1f °C]" <temperature> (TempSensors) {zwave="20:command=SENSOR_MULTILEVEL,sensor_type=1,refresh_interval=30"}
Switch Thermostat_Heating "Is Heating? [MAP(heating.map):%s]" <heating> {zwave="20:command=SWITCH_BINARY,refresh_interval=30"}
Number Thermostat_Battery "Thermostat Battery [%d %%]" (Batteries) {zwave="20:command=BATTERY"}

Switch BoilerReceiver "Is Boiler On? [MAP(heating.map):%s]" <heating> { zwave="19:1:command=SWITCH_BINARY,refresh_interval=30" }


ITEMS
