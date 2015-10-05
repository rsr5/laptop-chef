
package 'docker'

#service 'docker' do
#  action [:enable, :start]
#end

group 'docker' do
  action :create
end
