
node.default['authorization']['sudo']['users'] = %w(vagrant)

include_recipe 'sudo::default'
