directory node["thesetup"]["root"]
directory node["thesetup"]["bindir"]
directory node["thesetup"]["envdir"]

cookbook_file "#{node['thesetup']['bindir']}/the-setup" do
  mode   "0755"
  source "the-setup.sh"
end

thesetup_env "the-setup" do
  priority 10
  template "the-setup.sh.erb"
end

template "#{node['thesetup']['root']}/env.sh" do
  mode   "0755"
  source "env.sh.erb"
end

include_recipe "thesetup::git"
