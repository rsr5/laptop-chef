
package 'unzip'
package 'java-1.8.0-openjdk'

user 'openhab'

%w(/opt/openhab
   /opt/openhab/addons_cache
   /opt/openhab/user_scripts).each do |dir|
  directory dir do
    owner 'openhab'
  end
end

execute 'unpack openhab' do
  cwd '/opt/openhab'
  user 'openhab'
  command "unzip #{Chef::Config[:file_cache_path]}/openhab.zip"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/openhab.zip" do
  source 'https://bintray.com/artifact/download/openhab/bin/'\
         'distribution-1.7.1-runtime.zip'
  notifies :run, 'execute[unpack openhab]', :immediately
end

execute 'unpack addons' do
  cwd '/opt/openhab/addons_cache'
  user 'openhab'
  command "unzip #{Chef::Config[:file_cache_path]}/addons.zip"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/addons.zip" do
  source 'https://bintray.com/artifact/download/openhab/bin/'\
         'distribution-1.7.1-addons.zip'
  notifies :run, 'execute[unpack addons]', :immediately
end

# Setup the accumulator.
ruby_block 'item accumulator' do
  block do
    node.run_state['openhab'] = { 'items' => {}, 'groups' => Set.new }
  end
end

ruby_block 'item saver' do
  block do
    node.run_state['openhab']['items'].each do |filename, items|
      path = "/opt/openhab/configurations/items/#{filename}.items"
      item_file = ::File.open(path, 'w+')
      items.each do |item|
        binding = ''
        binding = " { #{item.binding} }" if item.binding

        icon = ' '
        icon = " <#{item.icon}> " if item.icon

        groups = ' '
        groups = ' (' + item.groups.join(' ') + ') ' if item.groups.size > 0

        label = ' '
        label = " \"#{item.label}\" " if item.label

        itemstr = <<-ITEM
/* Chef Added #{name} */
#{item.type} #{item.name}#{label}#{icon}#{groups}#{binding}
ITEM
        item_file.write(itemstr)
      end
      FileUtils.chown 'openhab', 'openhab', path
    end
  end
  action :nothing
end

ruby_block 'schedule saver' do
  block do
    # Does nothing
  end
  notifies :run, 'ruby_block[item saver]', :delayed
end
