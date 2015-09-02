require "socket"

cwd = File.dirname(__FILE__)

log_level :debug
log_location STDOUT

node_name Socket.gethostname

client_key             "#{cwd}/solo.pem"

validation_client_name ""
validation_key         "#{cwd}/validation.pem"

chef_server_url ""

cache_type    "BasicFile"
cache_options :path => "#{ENV['HOME']}/.chef/checksums"

cookbook_path      "#{cwd}/../cookbooks"
cookbook_copyright "Will Farrington"
cookbook_license   "MIT"
cookbook_email     "wcfarrington@gmail.com"

environment_path "#{cwd}/../environments"
