cwd = Dir.pwd

cache_path "#{cwd}/tmp/cache"
cookbook_path [
  "#{cwd}/cookbooks",
  "#{cwd}/berks-cookbooks",
]
data_bag_path "#{cwd}/data_bags"
role_path "#{cwd}/roles"
environment_path "#{cwd}/environments"
json_attribs "#{cwd}/config.json"

ssl_verify_mode :verify_peer
verify_api_cert true
