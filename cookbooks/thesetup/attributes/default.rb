default["thesetup"]["user_home"] = node["etc"]["passwd"][node["current_user"]]["dir"]

default["thesetup"]["root"] = "#{node['thesetup']['user_home']}/.the-setup"
default["thesetup"]["bindir"] = "#{node['thesetup']['root']}/bin"
default["thesetup"]["envdir"] = "#{node['thesetup']['root']}/env.d"
