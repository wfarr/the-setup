actions :set, :unset

default_action :set

attribute :host,
  :name_attribute => true,
  :kind_of        => String

attribute :protocol,
  :kind_of => String,
  :default => "https"
