git "#{node['thesetup']['user_home']}/.chruby" do
  enable_checkout false
  repository "https://github.com/postmodern/chruby"
  revision   "0dac40188e306cdf62b23f46bb953a2717eebbb6"
end

git "#{node['thesetup']['user_home']}/.ruby-build" do
  enable_checkout false
  repository "https://github.com/sstephenson/ruby-build"
  revision   "326b038697deb6da4f8047b1c414b9c2347b4934"
end

ruby_version node["ruby"]["default_version"]
