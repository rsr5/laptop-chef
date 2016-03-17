
module Home
  # Helpers for calculating the home directory
  module DSL
    def home(user, path = '')
      pre = (::Chef.node['os'] == 'linux') ? '/home/' : '/export/home/'
      ::File.join(pre, user, path)
    end
  end
end

Chef::Recipe.send(:include, Home::DSL)
Chef::Provider.send(:include, Home::DSL)
Chef::Resource.send(:include, Home::DSL)
