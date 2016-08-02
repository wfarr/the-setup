git "#{node['thesetup']['user_home']}/.chruby" do
  enable_checkout false
  repository "https://github.com/postmodern/chruby"
  revision   "0dac40188e306cdf62b23f46bb953a2717eebbb6"
end

git "#{node['thesetup']['user_home']}/.ruby-build" do
  enable_checkout false
  repository "https://github.com/sstephenson/ruby-build"
  revision   node["ruby"]["ruby-build"]["revision"]
end

ruby_version node["ruby"]["default_version"]

thesetup_env "ruby" do
  priority 10
  template "ruby.sh.erb"
end
