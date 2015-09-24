
node.default['authorization']['sudo']['users'] = %w(vagrant)
node.default['authorization']['sudo']['passwordless'] = true
node.default['authorization']['sudo']['include_sudoers_d'] = true

include_recipe 'sudo::default'

node.default['authorization']['sudo']['passwordless'] = false
