def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless installed?
    execute "#{gembin} install #{dem_args}"
  end
end

action :uninstall do
  if installed?
    execute "#{gembin} uninstall #{dem_args}"
  end
end

def installed?
  `#{gembin} spec -d #{dem_args} 2>&1 >/dev/null`
  $? == 0
end

def gembin
  "#{node['thesetup']['user_home']}/.rubies/#{new_resource.ruby}/bin/gem"
end

def dem_args
  "#{new_resource.gem} --version \"#{new_resource.version}\""
end
