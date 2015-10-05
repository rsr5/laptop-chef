
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
