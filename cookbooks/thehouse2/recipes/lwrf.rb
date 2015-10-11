
openhab_item 'Button_Landing' do
  filename 'lwrf'
  type 'Number'
  label 'Landing Mood [%d]'
  binding 'rfxcom="<16011049.16:Mood"'
end

openhab_item 'Button_LivingRoom' do
  filename 'lwrf'
  type 'Number'
  label 'Living Room Mood [%d]'
  binding 'rfxcom="<16010624.16:Mood"'
end
