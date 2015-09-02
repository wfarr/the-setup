def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template "#{node.thesetup.envdir}/#{new_resource.priority}_#{new_resource.script}.sh" do
    source    new_resource.template
    variables new_resource.variables
  end
end

action :delete do
  template "#{node.thesetup.envdir}/#{new_resource.priority}_#{new_resource.script}.sh" do
    action :destroy
  end
end
