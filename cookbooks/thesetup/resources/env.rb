actions :create, :delete

default_action :create

attribute :script,
  :name_attribute => true,
  :kind_of        => String

attribute :priority,
  :kind_of => Integer

attribute :template,
  :kind_of => String

attribute :variables,
  :kind_of => Hash

attr_accessor :exists
