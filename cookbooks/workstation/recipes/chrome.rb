
yum_repository 'google-chrome' do
  description 'google-chrome - $basearch'
  baseurl 'http://dl.google.com/linux/chrome/rpm/stable/$basearch'
  gpgkey 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
  enabled true
  gpgcheck true
  action :create
end

package 'google-chrome-stable'

link '/usr/bin/chrome' do
  to '/opt/google/chrome/chrome'
end
