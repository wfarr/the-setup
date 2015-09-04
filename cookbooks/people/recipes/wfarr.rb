ruby_versions = %w(
  2.1.2
  2.1.7
)

ruby_versions.each do |v|
  ruby_version v
end

homebrew_tap "railwaycat/emacsmacport"

package "emacs-mac" do
  options "--with-spacemacs-icon"
end
