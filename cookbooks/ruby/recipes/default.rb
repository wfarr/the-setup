git "#{node['thesetup']['user_home']}/.chruby" do
  enable_checkout false
  repository "https://github.com/postmodern/chruby"
  revision   "v0.3.9"
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
