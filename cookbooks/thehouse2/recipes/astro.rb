
openhab_item 'Sunset' do
  filename 'astro'
  type 'DateTime'
  label 'Sunset [%1$tH:%1$tM]'
  binding 'astro="planet=sun, type=set, property=end"'
end

openhab_item 'SunsetEvent' do
  filename 'astro'
  type 'Switch'
  binding 'astro="planet=sun, type=set, property=end, offset=-30"'
end
