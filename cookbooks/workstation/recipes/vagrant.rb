
include_recipe 'vagrant::fedora'

%w(vagrant-omnibus vagrant-berkshelf).each do |plugin|
  vagrant_plugin plugin do
    user 'robin'
  end 
end
