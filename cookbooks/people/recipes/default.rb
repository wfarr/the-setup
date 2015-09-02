begin
  include_recipe "people::#{node['current_user']}"
rescue Chef::Exceptions::RecipeNotFound => rnfe
  warn "No custom people recipe for user #{node['current_user']} found"
end
