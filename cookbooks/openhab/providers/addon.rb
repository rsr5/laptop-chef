
def whyrun_supported?
  true
end

use_inline_resources

action :create do

  addons = '/opt/openhab/addons/'
  addons_cache = '/opt/openhab/addons_cache/'

  remote_file "copy addon #{new_resource.name}" do 
    path "#{addons}/org.openhab.#{new_resource.name}-1.7.1.jar"
    source "file:///#{addons_cache}/org.openhab.#{new_resource.name}-1.7.1.jar" 
    owner 'openhab'
    group 'openhab'
  end

end
