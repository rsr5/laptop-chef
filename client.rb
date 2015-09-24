file_cache_path    "/var/chef/cache"
file_backup_path   "/var/chef/backup"
cookbook_path [File.dirname(File.expand_path(__FILE__)) + "/berks-cookbooks/"]
role_path []
log_level :info
verbose_logging false
enable_reporting false

encrypted_data_bag_secret nil




chef_zero.enabled true
local_mode true


