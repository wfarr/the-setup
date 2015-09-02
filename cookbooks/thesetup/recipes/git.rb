git_config "credential.helper" do
  value node.git.credential_helper
end

git_credential "github.com"

default_git_configs = data_bag_item_maybe("git_configs", "default")
user_git_configs    = data_bag_item_maybe("git_configs", node.current_user)

git_configs = default_git_configs.merge(user_git_configs)
%w(id data_bag chef_type credential.helper).each { |k| git_configs.delete(k) }

git_configs.each do |k, v|
  git_config k do
    value v
  end
end
