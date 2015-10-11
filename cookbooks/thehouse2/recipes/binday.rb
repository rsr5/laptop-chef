
python_package 'beautifulsoup4'

cookbook_file '/opt/openhab/user_scripts/binday.py' do
  owner 'openhab'
  group 'openhab'
  mode '0755'
  action :create
end

openhab_item 'BinDayJSON' do
  filename 'binday'
  type 'String'
  label 'Bin Day JSON'
  binding 'exec="<[/opt/openhab/user_scripts/binday.py:3600000:REGEX((.*?))]"'
end

openhab_item 'BinWasteDay' do
  filename 'binday'
  type 'String'
  label 'Waste Day [%s]'
end

openhab_item 'BinRecyclingDay' do
  filename 'binday'
  type 'String'
  label 'Recycling Day [%s]'
end
