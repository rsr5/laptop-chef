def whyrun_supported?
  true
end

use_inline_resources

action :install do
  systemd_service 'openhab' do
    timeout_start_sec 0
    exec_start new_resource.startup_script
    description 'Open Home Automation Bus'
    user 'openhab'

    install do
      wanted_by 'multi-user.target'
    end

    action [:create, :enable, :start]
  end
end
