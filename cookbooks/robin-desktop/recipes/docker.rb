
docker_service 'default' do
  action [:create, :start]
end

docker_image 'datasift/test-kitchen' do
  action :pull
end
