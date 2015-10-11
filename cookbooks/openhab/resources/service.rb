actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :startup_script, kind_of: String, default: '/opt/openhab/start.sh'

def initialize(*args)
  super
  @run_context.include_recipe 'openhab::_install'
end
