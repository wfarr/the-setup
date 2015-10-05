ruby_versions = %w(
  2.1.2
  2.1.7
)

ruby_versions.each do |v|
  ruby_version v
end

homebrew_tap "railwaycat/emacsmacport"

package "emacs-mac"# do
#  options "--with-spacemacs-icon"
#end

# package "librdkafka"
# package "kafka"
# package "kafkacat"
package "mysql"
package "postgresql"
package "redis"
# package "zookeeper"

# thesetup_env "java" do
#   priority 50
#   template "java.sh.erb"
# end
