require "fileutils"

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  new_resource.updated_by_last_action(false)

  if !version_installed(new_resource.version)
    execute "install ruby #{new_resource.version}" do
      command "#{ruby_build} #{new_resource.version} #{install_path(new_resource.version)}"
    end

    new_resource.updated_by_last_action(true)
  end

  node['ruby']['gems'].each do |g|
    ruby_gem "#{g['name']}" do
      version g['version']
      ruby new_resource.version
      action (g['action'] || :install)
    end
  end
end

action :delete do
  if version_installed(new_resource.version)
    FileUtils.rm_rf install_path(new_resource.version)
    new_resource.updated_by_last_action(true)
  else
    new_resource.updated_by_last_action(false)
  end
end

def ruby_build
  "#{node['thesetup']['user_home']}/.ruby-build/bin/ruby-build"
end

def install_path(version)
  "#{node['thesetup']['user_home']}/.rubies/#{version}"
end

def version_installed(version)
  ::File.executable?("#{install_path(version)}/bin/ruby")
end
