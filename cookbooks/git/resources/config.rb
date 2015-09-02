actions :set, :unset

default_action :set

attribute :name,
  :name_attribute => true,
  :kind_of        => String

attribute :value,
  :kind_of => String

attribute :exists,
  :kind_of => [TrueClass, FalseClass]

attribute :insync,
  :kind_of => [TrueClass, FalseClass]
