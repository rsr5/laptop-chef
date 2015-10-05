
require 'fileutils'

def whyrun_supported?
  true
end

use_inline_resources

action :create do

  ruby_block 'item accumulator' do
    block do

      unless node.run_state['openhab']['items'].has_key?(new_resource.filename)
        node.run_state['openhab']['items'][new_resource.filename] = []
      end

      if new_resource.type == 'Group'
        node.run_state['openhab']['groups'].add(new_resource.name)
      end

      if !new_resource.groups.to_set.subset? node.run_state['openhab']['groups']
        raise (new_resource.groups.to_set - node.run_state['openhab']['groups']).inspect
      end

      node.run_state['openhab']['items'][new_resource.filename].push(
        new_resource
      )
    end

  end

end
