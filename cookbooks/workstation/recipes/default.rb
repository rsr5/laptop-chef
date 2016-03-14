
include_recipe 'base::default'
include_recipe 'workstation::xwindows'
include_recipe 'workstation::audio'
include_recipe 'workstation::fonts'
include_recipe 'workstation::setup_chef'
include_recipe 'workstation::chrome'
include_recipe 'workstation::vpn'
include_recipe 'workstation::virtualbox' if node['enable_vagrant']
include_recipe 'workstation::vagrant'
