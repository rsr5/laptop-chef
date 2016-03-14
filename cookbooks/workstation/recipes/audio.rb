
multipackage 'bluetooth audio' do
  package_name %w(
    pavucontrol
    pulseaudio-module-bluetooth
  )
end

group 'audio' do
  action :modify
  members 'robin'
  append true
end
