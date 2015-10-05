actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true

def initialize(*args)
  super
  @run_context.include_recipe 'openhab::_install'
end
