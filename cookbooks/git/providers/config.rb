def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  @config = Chef::Resource::GitConfig.new(new_resource.name)

  cv = `git config --global --get '#{new_resource.name}'`

  if $? == 0
    @config.exists true
  else
    @config.exists false
  end

  if cv.strip == new_resource.value
    @config.insync true
  else
    @config.insync false
  end
end

action :set do
  unless @config.exists && @config.insync
    execute "set-git-config-#{new_resource.name}" do
      command "git config --global '#{new_resource.name}' '#{new_resource.value}'"
      not_if  { `git config --global --get '#{new_resource.name}'`.strip == new_resource.value }
    end
  end
end

action :unset do
  if @config.exists
    execute "delete-git-config-#{new_resource.key}" do
      command "git config --global --unset '#{new_resource.name}'"
      only_if "git config --global --get '#{new_resource.name}'"
    end
  end
end
